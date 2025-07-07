import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_event.dart';
import '../bloc/clothing_state.dart';
import '../cubit/filter_cubit.dart';
import '../models/models.dart';
import '../widgets/clothing_item_widget.dart';

import 'add_item_screen.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int)? onNavigateToTab;

  const HomeScreen({super.key, this.onNavigateToTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fabScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    ));
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with enhanced styling
          SliverAppBar.large(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TCloset',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Your Digital Wardrobe',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            backgroundColor: colorScheme.surface,
            surfaceTintColor: colorScheme.surfaceTint,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            snap: false,
            elevation: 0,
            scrolledUnderElevation: 1,
            actions: [
              // View Toggle Button
              BlocBuilder<FilterCubit, FilterState>(
                builder: (context, filterState) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.read<FilterCubit>().toggleViewMode();
                      },
                      icon: Icon(
                        filterState.isGridView
                            ? Icons.view_list_outlined
                            : Icons.grid_view_outlined,
                      ),
                      tooltip: filterState.isGridView
                          ? 'Switch to List View'
                          : 'Switch to Grid View',
                      style: IconButton.styleFrom(
                        foregroundColor: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),

              // Sort Menu Button
              BlocBuilder<FilterCubit, FilterState>(
                builder: (context, filterState) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: filterState.sortOption != SortOption.dateAdded
                          ? colorScheme.primaryContainer
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: PopupMenuButton<SortOption>(
                      icon: Icon(
                        Icons.sort_outlined,
                        color: filterState.sortOption != SortOption.dateAdded
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                      tooltip: 'Sort Options',
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      onSelected: (SortOption value) {
                        context.read<FilterCubit>().setSortOption(value);
                      },
                      itemBuilder: (context) => [
                        _buildSortMenuItem(
                          context,
                          SortOption.dateAdded,
                          'Date Added',
                          Icons.schedule_outlined,
                          filterState.sortOption,
                        ),
                        _buildSortMenuItem(
                          context,
                          SortOption.category,
                          'Category',
                          Icons.category_outlined,
                          filterState.sortOption,
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Filter Menu Button
              BlocBuilder<FilterCubit, FilterState>(
                builder: (context, filterState) {
                  return Container(
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: filterState.hasActiveFilters
                          ? colorScheme.primaryContainer
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () => _showCategoryFilter(context),
                      icon: Icon(
                        Icons.filter_list_outlined,
                        color: filterState.hasActiveFilters
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                      tooltip: 'Filter by Category',
                      style: IconButton.styleFrom(
                        foregroundColor: filterState.hasActiveFilters
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // Enhanced Filter Chips Section
          SliverToBoxAdapter(
            child: BlocBuilder<FilterCubit, FilterState>(
              builder: (context, filterState) {
                if (!filterState.hasActiveFilters) {
                  return const SizedBox.shrink();
                }

                return Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Active Filters',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              context.read<FilterCubit>().clearAllFilters();
                            },
                            icon: Icon(
                              Icons.clear_all,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            label: Text(
                              'Clear All',
                              style: TextStyle(color: colorScheme.primary),
                            ),
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          ...filterState.selectedCategories.map(
                            (category) => _buildFilterChip(
                              context,
                              category.displayName,
                              Icons.category_outlined,
                              () => context
                                  .read<FilterCubit>()
                                  .toggleCategory(category),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Enhanced Content Section
          SliverToBoxAdapter(
            child: BlocBuilder<ClothingBloc, ClothingState>(
              builder: (context, clothingState) {
                if (clothingState.status == ClothingStatus.loading) {
                  return _buildLoadingState(context);
                }

                if (clothingState.status == ClothingStatus.failure) {
                  return _buildErrorState(context, clothingState.errorMessage);
                }

                return BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, filterState) {
                    final filteredItems = context
                        .read<FilterCubit>()
                        .applyFilters(clothingState.items);

                    if (filteredItems.isEmpty) {
                      return _buildEmptyState(context, filterState);
                    }

                    return _buildItemsGrid(context, filteredItems, filterState);
                  },
                );
              },
            ),
          ),
        ],
      ),

      // Modern Floating Action Button
      floatingActionButton: ScaleTransition(
        scale: _fabScaleAnimation,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const AddItemScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    )),
                    child: child,
                  );
                },
              ),
            );
            if (result == true) {
              if (context.mounted) {
                context.read<ClothingBloc>().add(LoadClothingItems());
              }
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
          elevation: 3,
          highlightElevation: 6,
        ),
      ),
    );
  }

  PopupMenuItem<SortOption> _buildSortMenuItem(
    BuildContext context,
    SortOption value,
    String label,
    IconData icon,
    SortOption currentSort,
  ) {
    final theme = Theme.of(context);
    final isSelected = currentSort == value;

    return PopupMenuItem(
      value: value,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onDeleted,
  ) {
    final theme = Theme.of(context);

    return Chip(
      avatar: Icon(
        icon,
        size: 16,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      label: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
      deleteIcon: Icon(
        Icons.close,
        size: 16,
        color: theme.colorScheme.onPrimaryContainer,
      ),
      onDeleted: onDeleted,
      backgroundColor: theme.colorScheme.primaryContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'Loading your wardrobe...',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String? errorMessage) {
    final theme = Theme.of(context);

    return Container(
      height: 400,
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Oops! Something went wrong',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'An unexpected error occurred',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                context.read<ClothingBloc>().add(LoadClothingItems());
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, FilterState filterState) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 400,
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                filterState.hasActiveFilters
                    ? Icons.search_off_outlined
                    : Icons.checkroom_outlined,
                size: 48,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              filterState.hasActiveFilters
                  ? 'No items match your filters'
                  : 'Your wardrobe is empty',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              filterState.hasActiveFilters
                  ? 'Try adjusting your search criteria or add new items to your wardrobe'
                  : 'Start building your digital closet by adding your first clothing item',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (filterState.hasActiveFilters)
              OutlinedButton.icon(
                onPressed: () {
                  context.read<FilterCubit>().clearAllFilters();
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Filters'),
              )
            else
              FilledButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddItemScreen(),
                    ),
                  );
                  if (result == true && context.mounted) {
                    context.read<ClothingBloc>().add(LoadClothingItems());
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add First Item'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsGrid(
    BuildContext context,
    List<ClothingItem> items,
    FilterState filterState,
  ) {
    if (filterState.isGridView) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ClothingItemWidget(
              item: items[index],
              isGridView: true,
            );
          },
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return ClothingItemWidget(
              item: items[index],
              isGridView: false,
            );
          },
        ),
      );
    }
  }

  void _showCategoryFilter(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: const _CategorySelectionBottomSheet(),
      ),
    );
  }
}

class _CategorySelectionBottomSheet extends StatelessWidget {
  const _CategorySelectionBottomSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, filterState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 16, 16),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list_outlined,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Filter by Category',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ],
              ),
            ),

            // Categories List
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Clear All Categories option
                    _buildClearAllTile(
                      context,
                      filterState.selectedCategories,
                    ),

                    const SizedBox(height: 8),

                    // Individual category options
                    ...ClothingCategory.values
                        .map((category) => _buildCategoryTile(
                              context,
                              category,
                              category.displayName,
                              _getCategoryIcon(category),
                              filterState.selectedCategories,
                            )),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildClearAllTile(
    BuildContext context,
    Set<ClothingCategory> selectedCategories,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasSelections = selectedCategories.isNotEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: hasSelections
            ? colorScheme.errorContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: hasSelections
                ? colorScheme.errorContainer
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.clear_all,
            color: hasSelections
                ? colorScheme.onErrorContainer
                : colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
        title: Text(
          'Clear All Filters',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: hasSelections ? FontWeight.w600 : FontWeight.w400,
            color: hasSelections ? colorScheme.error : colorScheme.onSurface,
          ),
        ),
        trailing: hasSelections
            ? IconButton(
                onPressed: () {
                  context.read<FilterCubit>().clearCategories();
                },
                icon: Icon(
                  Icons.close,
                  color: colorScheme.error,
                  size: 20,
                ),
              )
            : null,
        onTap: hasSelections
            ? () {
                context.read<FilterCubit>().clearCategories();
              }
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildCategoryTile(
    BuildContext context,
    ClothingCategory category,
    String title,
    IconData icon,
    Set<ClothingCategory> selectedCategories,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = selectedCategories.contains(category);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (bool? value) {
            context.read<FilterCubit>().toggleCategory(category);
          },
          activeColor: colorScheme.primary,
        ),
        onTap: () {
          context.read<FilterCubit>().toggleCategory(category);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(ClothingCategory category) {
    switch (category) {
      case ClothingCategory.tops:
        return Icons.vertical_align_top;
      case ClothingCategory.bottoms:
        return Icons.vertical_align_bottom;
      case ClothingCategory.outerwear:
        return Icons.checkroom;
      case ClothingCategory.shoes:
        return Icons.sports_martial_arts;
      case ClothingCategory.accessories:
        return Icons.watch;
      case ClothingCategory.underwear:
        return Icons.style;
      case ClothingCategory.sleepwear:
        return Icons.bedtime;
      case ClothingCategory.sportswear:
        return Icons.fitness_center;
    }
  }
}
