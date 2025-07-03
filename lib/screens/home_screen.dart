import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_event.dart';
import '../bloc/clothing_state.dart';
import '../cubit/filter_cubit.dart';
import '../models/models.dart';
import '../widgets/clothing_item_widget.dart';

import '../constants/app_theme.dart';
import 'add_item_screen.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCloset'),
        backgroundColor: context.theme.appBar,
        actions: [
          // Sort Button
          BlocBuilder<FilterCubit, FilterState>(
            builder: (context, filterState) {
              return PopupMenuButton<SortOption>(
                icon: Icon(
                  Icons.sort,
                  color: filterState.sortOption != SortOption.dateAdded
                      ? context.theme.greenPrimary
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
                      ? context.theme.greenPrimary
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
                    Icon(filterState.isGridView ? Icons.grid_view : Icons.list),
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
                        .applyFilters(clothingState.items);

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
                              filterState.hasActiveFilters
                                  ? 'No items match your filters'
                                  : 'No clothing items yet',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              filterState.hasActiveFilters
                                  ? 'Try adjusting your filters'
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _CategorySelectionBottomSheet(),
    );
  }

  String _formatDateRange(DateRange range) {
    final start = '${range.startDate.day}/${range.startDate.month}';
    final end = '${range.endDate.day}/${range.endDate.month}';
    return '$start - $end';
  }

  Widget _CategorySelectionBottomSheet() {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, filterState) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Select Category',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // All Categories option
                      ListTile(
                        title: const Text('All'),
                        leading: Radio<ClothingCategory?>(
                          value: null,
                          groupValue: filterState.selectedCategory,
                          onChanged: (ClothingCategory? value) {
                            context.read<FilterCubit>().setCategory(value);
                            Navigator.of(context).pop();
                          },
                        ),
                        onTap: () {
                          context.read<FilterCubit>().setCategory(null);
                          Navigator.of(context).pop();
                        },
                      ),

                      // Individual category options
                      ...ClothingCategory.values.map((category) => ListTile(
                            title: Text(category.displayName),
                            leading: Radio<ClothingCategory?>(
                              value: category,
                              groupValue: filterState.selectedCategory,
                              onChanged: (ClothingCategory? value) {
                                context.read<FilterCubit>().setCategory(value);
                                Navigator.of(context).pop();
                              },
                            ),
                            onTap: () {
                              context.read<FilterCubit>().setCategory(category);
                              Navigator.of(context).pop();
                            },
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
