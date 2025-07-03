import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_event.dart';
import '../bloc/clothing_state.dart';
import '../cubit/filter_cubit.dart';
import '../models/models.dart';
import '../widgets/clothing_item_widget.dart';
import '../widgets/category_filter_chip.dart';
import '../widgets/advanced_filter_bottom_sheet.dart';
import 'add_item_screen.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCloset'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Sort Button
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, filterState) {
              return PopupMenuButton<SortOption>(
                icon: Icon(
                  Icons.sort,
                  color: filterState.sortOption != SortOption.dateAdded
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onSelected: (SortOption value) {
                  context.read<FilterCubit>().setSortOption(value);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: SortOption.dateAdded,
                    child: Row(
                      children: [
                        Icon(
                          filterState.sortOption == SortOption.dateAdded
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                        ),
                        const SizedBox(width: 8),
                        const Text('Date Added'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: SortOption.category,
                    child: Row(
                      children: [
                        Icon(
                          filterState.sortOption == SortOption.category
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                        ),
                        const SizedBox(width: 8),
                        const Text('Category'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: SortOption.name,
                    child: Row(
                      children: [
                        Icon(
                          filterState.sortOption == SortOption.name
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                        ),
                        const SizedBox(width: 8),
                        const Text('Name'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: null,
                    onTap: () {
                      context.read<FilterCubit>().toggleSortOrder();
                    },
                    child: Row(
                      children: [
                        Icon(filterState.sortOrder == SortOrder.ascending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                        const SizedBox(width: 8),
                        Text(filterState.sortOrder == SortOrder.ascending
                            ? 'Ascending'
                            : 'Descending'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Advanced Filter Button
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, filterState) {
              return IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: filterState.hasActiveFilters
                      ? Theme.of(context).colorScheme.primary
                      : null,
                ),
                onPressed: () {
                  _showAdvancedFilters(context);
                },
              );
            },
          ),

          // View Mode Toggle
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, filterState) {
              return IconButton(
                icon:
                    Icon(filterState.isGridView ? Icons.list : Icons.grid_view),
                onPressed: () {
                  context.read<FilterCubit>().toggleViewMode();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search clothing items...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context
                              .read<ClothingBloc>()
                              .add(const SearchClothingItems(''));
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<ClothingBloc>().add(SearchClothingItems(value));
              },
            ),
          ),

          // Active Filters Display
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, filterState) {
              if (!filterState.hasActiveFilters) return const SizedBox();

              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (filterState.selectedCategory != null)
                      Chip(
                        label: Text(
                            'Category: ${filterState.selectedCategory!.displayName}'),
                        onDeleted: () {
                          context.read<FilterCubit>().setCategory(null);
                        },
                      ),
                    ...filterState.selectedTags.map((tag) => Chip(
                          label: Text('Tag: $tag'),
                          onDeleted: () {
                            context.read<FilterCubit>().removeTag(tag);
                          },
                        )),
                    if (filterState.dateRange != null)
                      Chip(
                        label: Text(
                            'Date Range: ${_formatDateRange(filterState.dateRange!)}'),
                        onDeleted: () {
                          context.read<FilterCubit>().setDateRange(null);
                        },
                      ),
                    ActionChip(
                      label: const Text('Clear All'),
                      onPressed: () {
                        context.read<FilterCubit>().clearAllFilters();
                      },
                    ),
                  ],
                ),
              );
            },
          ),

          // Category Filters
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryFilterChip(
                  label: 'All',
                  category: null,
                  onSelected: (category) {
                    context.read<FilterCubit>().setCategory(category);
                  },
                ),
                const SizedBox(width: 8),
                ...ClothingCategory.values.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CategoryFilterChip(
                      label: category.displayName,
                      category: category,
                      onSelected: (selectedCategory) {
                        context
                            .read<FilterCubit>()
                            .setCategory(selectedCategory);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Clothing Items List/Grid
          Expanded(
            child: BlocBuilder<ClothingBloc, ClothingState>(
              builder: (context, clothingState) {
                if (clothingState.status == ClothingStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (clothingState.status == ClothingStatus.failure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${clothingState.errorMessage}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<ClothingBloc>()
                                .add(LoadClothingItems());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, filterState) {
                    // Apply enhanced filtering
                    final filteredItems = context
                        .read<FilterCubit>()
                        .applyFilters(clothingState.searchQuery.isEmpty
                            ? clothingState.items
                            : clothingState.filteredItems);

                    if (filteredItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.checkroom_outlined,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              filterState.hasActiveFilters ||
                                      clothingState.searchQuery.isNotEmpty
                                  ? 'No items match your filters'
                                  : 'No clothing items yet',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              filterState.hasActiveFilters ||
                                      clothingState.searchQuery.isNotEmpty
                                  ? 'Try adjusting your filters or search terms'
                                  : 'Add your first clothing item!',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (filterState.isGridView) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          return ClothingItemWidget(
                            item: filteredItems[index],
                            isGridView: true,
                          );
                        },
                      );
                    } else {
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return ClothingItemWidget(
                            item: filteredItems[index],
                            isGridView: false,
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItemScreen()),
          );
          if (result == true) {
            // Refresh the list if item was added
            if (context.mounted) {
              context.read<ClothingBloc>().add(LoadClothingItems());
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAdvancedFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AdvancedFilterBottomSheet(),
    );
  }

  String _formatDateRange(DateRange range) {
    final start = '${range.startDate.day}/${range.startDate.month}';
    final end = '${range.endDate.day}/${range.endDate.month}';
    return '$start - $end';
  }
}
