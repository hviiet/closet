import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/filter_cubit.dart';
import '../models/models.dart';

class CategoryFilterChip extends StatelessWidget {
  final String label;
  final ClothingCategory category;
  final Function(ClothingCategory) onSelected;

  const CategoryFilterChip({
    super.key,
    required this.label,
    required this.category,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, filterState) {
        final isSelected = filterState.selectedCategories.contains(category);

        return FilterChip(
          label: Text(label),
          selected: isSelected,
          onSelected: (selected) {
            onSelected(category);
          },
          selectedColor: Theme.of(context).colorScheme.primaryContainer,
          checkmarkColor: Theme.of(context).colorScheme.onPrimaryContainer,
        );
      },
    );
  }
}
