import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../repositories/supabase_outfit_repository.dart';
import '../repositories/supabase_clothing_repository.dart';
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
  late final SupabaseOutfitRepository _outfitRepository;

  @override
  void initState() {
    super.initState();
    _outfitRepository = context.read<SupabaseOutfitRepository>();
    _loadOutfits();
  }

  Future<void> _loadOutfits() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final outfitRepository = context.read<SupabaseOutfitRepository>();
      final clothingRepository = context.read<SupabaseClothingRepository>();

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadOutfits,
        child: CustomScrollView(
          slivers: [
            // Modern App Bar with enhanced styling (matching home screen)
            SliverAppBar.large(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Outfits',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'Create and manage your outfits',
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

            // Content Section
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return SliverFillRemaining(
        child: Center(
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
        ),
      );
    }

    if (_outfits.isEmpty) {
      return SliverFillRemaining(
        child: Center(
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
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final outfit = _outfits[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index < _outfits.length - 1 ? 16.0 : 0.0,
              ),
              child: _buildOutfitCard(outfit),
            );
          },
          childCount: _outfits.length,
        ),
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
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: outfitItems.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 12),
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
                  height: 120,
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
                              .withValues(alpha: 0.1),
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
                  spacing: 12,
                  runSpacing: 12,
                  children: items.map((item) {
                    return SizedBox(
                      width: 100,
                      height: 120,
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
                              .withValues(alpha: 0.1),
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
      final wasMounted = mounted;
      try {
        await _outfitRepository.deleteOutfit(outfit.id);
        if (wasMounted && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Outfit deleted successfully')),
          );
          _loadOutfits();
        }
      } catch (e) {
        if (wasMounted && mounted) {
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
