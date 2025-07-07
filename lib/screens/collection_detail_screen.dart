import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_theme.dart';
import '../cubit/collection_cubit.dart';
import '../models/models.dart';
import '../repositories/hive_clothing_repository.dart';
import '../repositories/hive_outfit_repository.dart';
import '../repositories/hive_collection_repository.dart';
import '../widgets/clothing_item_widget.dart';
import 'edit_collection_screen.dart';

class CollectionDetailScreen extends StatefulWidget {
  final Collection collection;

  const CollectionDetailScreen({
    super.key,
    required this.collection,
  });

  @override
  State<CollectionDetailScreen> createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<ClothingItem> _items = [];
  List<OutfitSet> _outfits = [];
  bool _isLoading = true;
  late Collection _currentCollection;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _currentCollection = widget.collection;
    _loadCollectionData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadCollectionData() async {
    try {
      setState(() => _isLoading = true);

      final clothingRepo = context.read<HiveClothingRepository>();
      final outfitRepo = context.read<HiveOutfitRepository>();
      final collectionRepo = context.read<HiveCollectionRepository>();

      // Get the latest collection data
      final latestCollection =
          await collectionRepo.getCollectionById(_currentCollection.id);
      if (latestCollection != null) {
        _currentCollection = latestCollection;
      }

      // Load items
      final allItems = await clothingRepo.getAllItems();
      final items = allItems
          .where((item) => _currentCollection.itemIds.contains(item.id))
          .toList();

      // Load outfits
      final allOutfits = await outfitRepo.getAllOutfits();
      final outfits = allOutfits
          .where((outfit) => _currentCollection.outfitIds.contains(outfit.id))
          .toList();

      setState(() {
        _items = items;
        _outfits = outfits;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading collection data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection Detail'),
        backgroundColor: context.theme.appBar,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteDialog();
              }
              if (value == 'edit') {
                _editCollection();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit Collection'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete Collection'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Collection Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.theme.greenPrimary.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: context.theme.greenPrimary.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.collections,
                      color: context.theme.greenPrimary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Collection ${_currentCollection.id}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Created: ${_formatDate(_currentCollection.dateCreated)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total: ${_currentCollection.itemIds.length} items, ${_currentCollection.outfitIds.length} outfits',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'Items (${_currentCollection.itemIds.length})',
                  icon: const Icon(Icons.checkroom),
                ),
                Tab(
                  text: 'Outfits (${_currentCollection.outfitIds.length})',
                  icon: const Icon(Icons.style),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildItemsTab(),
                      _buildOutfitsTab(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsTab() {
    if (_items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checkroom_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No items in this collection',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Some items may have been deleted',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) {
        return ClothingItemWidget(
          item: _items[index],
          isGridView: true,
        );
      },
    );
  }

  Widget _buildOutfitsTab() {
    if (_outfits.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.style_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No outfits in this collection',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Some outfits may have been deleted',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _outfits.length,
      itemBuilder: (context, index) {
        final outfit = _outfits[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  context.theme.greenPrimary.withValues(alpha: 0.2),
              child: Icon(
                Icons.style,
                color: context.theme.greenPrimary,
              ),
            ),
            title: Text(
              outfit.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${outfit.itemIds.length} items'),
                Text(
                  'Created: ${_formatDate(outfit.dateCreated)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to outfit detail or show outfit preview
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Viewing ${outfit.name}')),
              );
            },
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _editCollection() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => EditCollectionScreen(
          collection: _currentCollection,
          existingItems: _items,
          existingOutfits: _outfits,
        ),
      ),
    );

    if (result == true && mounted) {
      // Refresh collection data
      await _loadCollectionData();
      // Also refresh the collection list
      context.read<CollectionCubit>().loadCollections();
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Collection'),
        content: Text(
          'Are you sure you want to delete Collection ${_currentCollection.id}?\n\nThis action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog

              try {
                await context
                    .read<CollectionCubit>()
                    .deleteCollection(_currentCollection.id);

                if (mounted) {
                  Navigator.pop(context); // Go back to collection list
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Collection deleted successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting collection: $e')),
                  );
                }
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
