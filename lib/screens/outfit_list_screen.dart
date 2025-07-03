import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../repositories/hive_outfit_repository.dart';
import '../repositories/hive_clothing_repository.dart';
import '../cubit/outfit_cubit.dart';
import '../widgets/clothing_item_widget.dart';
import '../constants/app_theme.dart';
import 'outfit_builder_screen.dart';

class OutfitListScreen extends StatefulWidget {
  const OutfitListScreen({super.key});

  @override
  State<OutfitListScreen> createState() => _OutfitListScreenState();
}

class _OutfitListScreenState extends State<OutfitListScreen> {
  List<OutfitSet> _outfits = [];
  List<ClothingItem> _allClothingItems = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadOutfits();
  }

  Future<void> _loadOutfits() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final outfitRepository = context.read<HiveOutfitRepository>();
      final clothingRepository = context.read<HiveClothingRepository>();

      final outfits = await outfitRepository.getAllOutfits();
      final clothingItems = await clothingRepository.getAllItems();

      setState(() {
        _outfits = outfits;
        _allClothingItems = clothingItems;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Outfits'),
        backgroundColor: context.theme.appBar,
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (context) => const OutfitBuilderScreen(),
                ),
              );
              if (result == true) {
                _loadOutfits();
              }
            },
            icon: const Icon(Icons.add),
            tooltip: 'Create New Outfit',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
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
            Text('Error loading outfits: $_errorMessage'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadOutfits,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_outfits.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.style_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No outfits yet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create your first outfit to get started',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OutfitBuilderScreen(),
                  ),
                );
                if (result == true) {
                  _loadOutfits();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Create Outfit'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadOutfits,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _outfits.length,
        itemBuilder: (context, index) {
          final outfit = _outfits[index];
          return _buildOutfitCard(outfit);
        },
      ),
    );
  }

  Widget _buildOutfitCard(OutfitSet outfit) {
    final outfitItems = _allClothingItems
        .where((item) => outfit.itemIds.contains(item.id))
        .toList();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showOutfitDetails(outfit, outfitItems),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with name and actions
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          outfit.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${outfitItems.length} items • ${_formatDate(outfit.dateCreated)}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _editOutfit(outfit);
                          break;
                        case 'delete':
                          _deleteOutfit(outfit);
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Outfit items preview
              if (outfitItems.isNotEmpty) ...[
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: outfitItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 80,
                        margin: const EdgeInsets.only(right: 8),
                        child: ClothingItemWidget(
                          item: outfitItems[index],
                          isGridView: true,
                          handleOnTap: false,
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Some items may have been deleted',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],

              // Tags if available
              if (outfit.tags != null && outfit.tags!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: outfit.tags!
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
                ),
              ],

              // Notes if available
              if (outfit.notes != null && outfit.notes!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  outfit.notes!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[700],
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showOutfitDetails(OutfitSet outfit, List<ClothingItem> items) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(outfit.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created: ${_formatDate(outfit.dateCreated)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              if (items.isNotEmpty) ...[
                const Text(
                  'Items:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((item) {
                    return SizedBox(
                      width: 80,
                      height: 100,
                      child: ClothingItemWidget(
                        item: item,
                        isGridView: true,
                        handleOnTap: false,
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (outfit.tags != null && outfit.tags!.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Tags:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: outfit.tags!
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (outfit.notes != null && outfit.notes!.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Notes:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(outfit.notes!),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _editOutfit(outfit);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  Future<void> _editOutfit(OutfitSet outfit) async {
    // Set up the outfit for editing in the cubit
    context.read<OutfitCubit>().startEditing(outfit, _allClothingItems);

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const OutfitBuilderScreen(),
      ),
    );

    if (result == true) {
      _loadOutfits();
    }
  }

  Future<void> _deleteOutfit(OutfitSet outfit) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Outfit'),
        content: Text('Are you sure you want to delete "${outfit.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await context.read<HiveOutfitRepository>().deleteOutfit(outfit.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Outfit deleted successfully')),
          );
          _loadOutfits();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting outfit: $e')),
          );
        }
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
