import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_event.dart';
import '../bloc/clothing_state.dart';
import '../cubit/outfit_cubit.dart';
import '../widgets/clothing_item_widget.dart';
import '../repositories/hive_outfit_repository.dart';
import '../constants/app_theme.dart';

class OutfitBuilderScreen extends StatefulWidget {
  const OutfitBuilderScreen({super.key});

  @override
  State<OutfitBuilderScreen> createState() => _OutfitBuilderScreenState();
}

class _OutfitBuilderScreenState extends State<OutfitBuilderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final _uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: ClothingCategory.values.length + 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _notesController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outfit Builder'),
        backgroundColor: context.theme.appBar,
        actions: [
          BlocBuilder<OutfitCubit, OutfitState>(
            builder: (context, outfitState) {
              return IconButton(
                onPressed: outfitState.canSaveOutfit ? _showSaveDialog : null,
                icon: const Icon(Icons.save),
                tooltip: 'Save Outfit',
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            const Tab(text: 'Preview'),
            ...ClothingCategory.values.map(
              (category) => Tab(text: category.displayName),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ClothingBloc, ClothingState>(
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
                    color: context.theme.error,
                  ),
                  const SizedBox(height: 16),
                  Text('Error loading items: ${clothingState.errorMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ClothingBloc>().add(LoadClothingItems());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildPreviewTab(),
              ...ClothingCategory.values.map(
                (category) => _buildCategoryTab(category, clothingState.items),
              ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<OutfitCubit, OutfitState>(
        builder: (context, outfitState) {
          if (outfitState.selectedItems.isEmpty) return const SizedBox();

          return FloatingActionButton.extended(
            heroTag: 'outfit_fab',
            onPressed: () {
              context.read<OutfitCubit>().clearSelection();
            },
            icon: const Icon(Icons.clear),
            label: const Text('Clear All'),
          );
        },
      ),
    );
  }

  Widget _buildPreviewTab() {
    return BlocBuilder<OutfitCubit, OutfitState>(
      builder: (context, outfitState) {
        if (outfitState.selectedItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.style_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No items selected',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 8),
                Text(
                  'Select items from different categories to create an outfit',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Outfit Preview
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.style,
                            color: context.theme.greenPrimary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Outfit Preview',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: context.theme.greenPrimary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: outfitState.selectedItems.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              ClothingItemWidget(
                                item: outfitState.selectedItems[index],
                                isGridView: true,
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () {
                                    context.read<OutfitCubit>().removeItem(
                                          outfitState.selectedItems[index],
                                        );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Category Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected by Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      ...ClothingCategory.values.map((category) {
                        final item = outfitState.selectedByCategory[category];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  category.displayName,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Icon(
                                item != null ? Icons.check : Icons.remove,
                                color:
                                    item != null ? Colors.green : Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item != null ? 'Selected' : 'Not selected',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: item != null
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryTab(
      ClothingCategory category, List<ClothingItem> allItems) {
    final categoryItems =
        allItems.where((item) => item.category == category).toList();

    if (categoryItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.checkroom_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No ${category.displayName.toLowerCase()} found',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Add some ${category.displayName.toLowerCase()} to your wardrobe first',
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return BlocBuilder<OutfitCubit, OutfitState>(
      builder: (context, outfitState) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: categoryItems.length,
          itemBuilder: (context, index) {
            final item = categoryItems[index];
            final isSelected = outfitState.selectedItems.contains(item);

            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<OutfitCubit>().selectItem(item);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClothingItemWidget(
                      item: item,
                      isGridView: true,
                      handleOnTap: false,
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSaveDialog() {
    final outfitState = context.read<OutfitCubit>().state;

    if (outfitState.isEditing) {
      _nameController.text = outfitState.outfitName ?? '';
      _notesController.text = outfitState.notes ?? '';
      _tagsController.text = outfitState.tags?.join(', ') ?? '';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(outfitState.isEditing ? 'Update Outfit' : 'Save Outfit'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selected items: ${outfitState.selectedItems.length}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'Note: You can save outfits with any number of items',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Outfit Name (Optional)',
                  hintText: 'Leave empty for auto-generated name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags (comma separated)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _saveOutfit();
              Navigator.pop(context);
            },
            child: Text(outfitState.isEditing ? 'Update' : 'Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveOutfit() async {
    final outfitState = context.read<OutfitCubit>().state;

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    // Generate default name if none provided
    String outfitName = _nameController.text.trim();
    if (outfitName.isEmpty) {
      final date = DateTime.now();
      final formattedDate = '${date.day}/${date.month}/${date.year}';
      outfitName = 'Outfit $formattedDate';
    }

    final outfit = OutfitSet(
      id: outfitState.isEditing ? outfitState.editingOutfitId! : _uuid.v4(),
      name: outfitName,
      itemIds: outfitState.selectedItems.map((item) => item.id).toList(),
      dateCreated: DateTime.now(),
      notes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      tags: tags.isNotEmpty ? tags : null,
    );

    try {
      final outfitRepository = context.read<HiveOutfitRepository>();
      if (outfitState.isEditing) {
        await outfitRepository.updateOutfit(outfit);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Outfit updated successfully!')),
          );
        }
      } else {
        await outfitRepository.addOutfit(outfit);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Outfit saved successfully!')),
          );
        }
      }

      // Clear the selection after saving
      if (mounted) {
        context.read<OutfitCubit>().clearSelection();
        _nameController.clear();
        _notesController.clear();
        _tagsController.clear();

        // Return success result
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving outfit: $e')),
        );
      }
    }
  }
}
