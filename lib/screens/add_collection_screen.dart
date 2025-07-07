import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/app_theme.dart';
import '../cubit/collection_cubit.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_state.dart';
import '../repositories/hive_outfit_repository.dart';
import '../models/models.dart';
import '../widgets/clothing_item_widget.dart';

class AddCollectionScreen extends StatefulWidget {
  const AddCollectionScreen({super.key});

  @override
  State<AddCollectionScreen> createState() => _AddCollectionScreenState();
}

class _AddCollectionScreenState extends State<AddCollectionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<String> _selectedItemIds = {};
  final Set<String> _selectedOutfitIds = {};
  List<OutfitSet> _outfits = [];
  bool _isLoadingOutfits = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadOutfits();
  }

  Future<void> _loadOutfits() async {
    try {
      final outfitRepository = context.read<HiveOutfitRepository>();
      final outfits = await outfitRepository.getAllOutfits();
      setState(() {
        _outfits = outfits;
        _isLoadingOutfits = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingOutfits = false;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Collection'),
        backgroundColor: context.theme.appBar,
        actions: [
          TextButton(
            onPressed: _createCollection,
            child: Text(
              'Create',
              style: TextStyle(color: context.theme.greenPrimary),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Clothing', icon: Icon(Icons.checkroom)),
            Tab(text: 'Outfits', icon: Icon(Icons.style)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildClothingTab(),
          _buildOutfitsTab(),
        ],
      ),
    );
  }

  Widget _buildClothingTab() {
    return BlocBuilder<ClothingBloc, ClothingState>(
      builder: (context, state) {
        if (state.status == ClothingStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ClothingStatus.failure) {
          return Center(
            child: Text('Error loading clothing items: ${state.errorMessage}'),
          );
        }

        if (state.items.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.checkroom_outlined, size: 64),
                SizedBox(height: 16),
                Text('No clothing items available'),
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
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            final item = state.items[index];
            final isSelected = _selectedItemIds.contains(item.id);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedItemIds.remove(item.id);
                  } else {
                    _selectedItemIds.add(item.id);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? context.theme.greenPrimary
                        : Colors.transparent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    ClothingItemWidget(
                      item: item,
                      isGridView: true,
                      handleOnTap: false,
                    ),
                    if (isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.theme.greenPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOutfitsTab() {
    if (_isLoadingOutfits) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_outfits.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.style_outlined, size: 64),
            SizedBox(height: 16),
            Text('No outfits available'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _outfits.length,
      itemBuilder: (context, index) {
        final outfit = _outfits[index];
        final isSelected = _selectedOutfitIds.contains(outfit.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isSelected
                  ? context.theme.greenPrimary
                  : context.theme.greenPrimary.withValues(alpha: 0.2),
              child: Icon(
                Icons.style,
                color: isSelected ? Colors.white : context.theme.greenPrimary,
              ),
            ),
            title: Text(outfit.name),
            subtitle: Text('${outfit.itemIds.length} items'),
            trailing: isSelected
                ? Icon(Icons.check_circle, color: context.theme.greenPrimary)
                : const Icon(Icons.radio_button_unchecked),
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedOutfitIds.remove(outfit.id);
                } else {
                  _selectedOutfitIds.add(outfit.id);
                }
              });
            },
          ),
        );
      },
    );
  }

  void _createCollection() async {
    if (_selectedItemIds.isEmpty && _selectedOutfitIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one item or outfit'),
        ),
      );
      return;
    }

    try {
      final collectionId = DateTime.now().millisecondsSinceEpoch.toString();

      await context.read<CollectionCubit>().createCollection(
            id: collectionId,
            itemIds: _selectedItemIds.toList(),
            outfitIds: _selectedOutfitIds.toList(),
          );

      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating collection: $e')),
        );
      }
    }
  }
}
