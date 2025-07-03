import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import '../bloc/clothing_bloc.dart';
import '../bloc/clothing_event.dart';
import '../services/file_storage_service.dart';

class ClothingItemWidget extends StatelessWidget {
  final ClothingItem item;
  final bool isGridView;
  final bool handleOnTap;

  const ClothingItemWidget({
    super.key,
    required this.item,
    required this.isGridView,
    this.handleOnTap = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return _buildGridItem(context);
    } else {
      return _buildListItem(context);
    }
  }

  Widget _buildGridItem(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: handleOnTap ? () => _showItemDetails(context) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _buildImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (item.notes?.isNotEmpty == true) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.notes!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _showItemDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildImage(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category.displayName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (item.notes?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.notes!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(item.dateAdded),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'delete':
                      _confirmDelete(context);
                      break;
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Builder(
      builder: (context) {
        return FutureBuilder<bool>(
          future:
              context.read<FileStorageService>().imageExists(item.imagePath),
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return Image.file(
                File(item.imagePath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildPlaceholder();
                },
              );
            }
            return _buildPlaceholder();
          },
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.checkroom,
        size: 40,
        color: Colors.grey,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showItemDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.category.displayName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: _buildImage(),
              ),
            ),
            const SizedBox(height: 16),
            Text('Added: ${_formatDate(item.dateAdded)}'),
            if (item.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text('Notes: ${item.notes}'),
            ],
            if (item.tags?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                children: item.tags!
                    .map((tag) => Chip(
                          label: Text(tag),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _confirmDelete(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content:
            const Text('Are you sure you want to delete this clothing item?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ClothingBloc>().add(DeleteClothingItem(item.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
