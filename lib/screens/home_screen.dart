import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_event.dart';
import '../bloc/clothing_state.dart';
import '../cubit/filter_cubit.dart';
import '../models/models.dart';
import '../widgets/clothing_item_widget.dart';
import '../widgets/category_filter_chip.dart';
import 'add_item_screen.dart';
import 'outfit_builder_screen.dart';
import 'trip_planner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'outfits':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OutfitBuilderScreen()),
                  );
                  break;
                case 'trips':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TripPlannerScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'outfits',
                child: Row(
                  children: [
                    Icon(Icons.style),
                    SizedBox(width: 8),
                    Text('Outfits'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'trips',
                child: Row(
                  children: [
                    Icon(Icons.travel_explore),
                    SizedBox(width: 8),
                    Text('Trips'),
                  ],
                ),
              ),
            ],
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
                    context
                        .read<ClothingBloc>()
                        .add(FilterClothingByCategory(category));
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
                        context
                            .read<ClothingBloc>()
                            .add(FilterClothingByCategory(selectedCategory));
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

                if (clothingState.filteredItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.checkroom_outlined,
                          size: 64,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          clothingState.searchQuery.isNotEmpty
                              ? 'No items found for "${clothingState.searchQuery}"'
                              : 'No clothing items yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          clothingState.searchQuery.isNotEmpty
                              ? 'Try a different search term'
                              : 'Add your first clothing item!',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  );
                }

                return BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, filterState) {
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
                        itemCount: clothingState.filteredItems.length,
                        itemBuilder: (context, index) {
                          return ClothingItemWidget(
                            item: clothingState.filteredItems[index],
                            isGridView: true,
                          );
                        },
                      );
                    } else {
                      return ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: clothingState.filteredItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return ClothingItemWidget(
                            item: clothingState.filteredItems[index],
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
}
