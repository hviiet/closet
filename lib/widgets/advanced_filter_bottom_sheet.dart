import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/filter_cubit.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_state.dart';

class AdvancedFilterBottomSheet extends StatefulWidget {
  const AdvancedFilterBottomSheet({super.key});

  @override
  State<AdvancedFilterBottomSheet> createState() =>
      _AdvancedFilterBottomSheetState();
}

class _AdvancedFilterBottomSheetState extends State<AdvancedFilterBottomSheet> {
  final TextEditingController _tagController = TextEditingController();

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Advanced Filters',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    BlocBuilder<FilterCubit, FilterState>(
                      builder: (context, filterState) {
                        return TextButton(
                          onPressed: filterState.hasActiveFilters
                              ? () {
                                  context.read<FilterCubit>().clearAllFilters();
                                }
                              : null,
                          child: const Text('Clear All'),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const Divider(),

              // Content
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  children: [
                    // Tags Section
                    _buildTagsSection(),

                    const SizedBox(height: 24),

                    // Date Range Section
                    _buildDateRangeSection(),

                    const SizedBox(height: 24),

                    // Sort Options Section
                    _buildSortSection(),

                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTagsSection() {
    return BlocBuilder<ClothingBloc, ClothingState>(
      builder: (context, clothingState) {
        final availableTags =
            context.read<FilterCubit>().getAvailableTags(clothingState.items);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tags',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Add Tag Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      hintText: 'Add tag filter...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        context.read<FilterCubit>().addTag(value.trim());
                        _tagController.clear();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    if (_tagController.text.trim().isNotEmpty) {
                      context
                          .read<FilterCubit>()
                          .addTag(_tagController.text.trim());
                      _tagController.clear();
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Selected Tags
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, filterState) {
                if (filterState.selectedTags.isEmpty && availableTags.isEmpty) {
                  return const Text(
                    'No tags available. Add tags to clothing items first.',
                    style: TextStyle(color: Colors.grey),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (filterState.selectedTags.isNotEmpty) ...[
                      const Text('Selected Tags:',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: filterState.selectedTags
                            .map((tag) => Chip(
                                  label: Text(tag),
                                  onDeleted: () {
                                    context.read<FilterCubit>().removeTag(tag);
                                  },
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                    ],
                    if (availableTags.isNotEmpty) ...[
                      const Text('Available Tags:',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: availableTags
                            .where((tag) =>
                                !filterState.selectedTags.contains(tag))
                            .map((tag) => ActionChip(
                                  label: Text(tag),
                                  onPressed: () {
                                    context.read<FilterCubit>().addTag(tag);
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDateRangeSection() {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, filterState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date Range',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: Text(
                  filterState.dateRange != null
                      ? '${_formatDate(filterState.dateRange!.startDate)} - ${_formatDate(filterState.dateRange!.endDate)}'
                      : 'Select date range',
                ),
                trailing: filterState.dateRange != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          context.read<FilterCubit>().setDateRange(null);
                        },
                      )
                    : const Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    initialDateRange: filterState.dateRange != null
                        ? DateTimeRange(
                            start: filterState.dateRange!.startDate,
                            end: filterState.dateRange!.endDate,
                          )
                        : null,
                  );

                  if (range != null && mounted) {
                    context.read<FilterCubit>().setDateRange(
                          DateRange(startDate: range.start, endDate: range.end),
                        );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSortSection() {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, filterState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort Options',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // Sort Option
            Card(
              child: Column(
                children: [
                  RadioListTile<SortOption>(
                    title: const Text('Date Added'),
                    value: SortOption.dateAdded,
                    groupValue: filterState.sortOption,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<FilterCubit>().setSortOption(value);
                      }
                    },
                  ),
                  RadioListTile<SortOption>(
                    title: const Text('Category'),
                    value: SortOption.category,
                    groupValue: filterState.sortOption,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<FilterCubit>().setSortOption(value);
                      }
                    },
                  ),
                  RadioListTile<SortOption>(
                    title: const Text('Name'),
                    value: SortOption.name,
                    groupValue: filterState.sortOption,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<FilterCubit>().setSortOption(value);
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Sort Order
            Card(
              child: SwitchListTile(
                title: const Text('Sort Order'),
                subtitle: Text(filterState.sortOrder == SortOrder.ascending
                    ? 'Ascending'
                    : 'Descending'),
                value: filterState.sortOrder == SortOrder.ascending,
                onChanged: (value) {
                  context.read<FilterCubit>().setSortOrder(
                        value ? SortOrder.ascending : SortOrder.descending,
                      );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
