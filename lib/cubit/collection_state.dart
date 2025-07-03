part of 'collection_cubit.dart';

enum CollectionStatus { initial, loading, success, failure }

class CollectionState extends Equatable {
  const CollectionState({
    this.status = CollectionStatus.initial,
    this.collections = const [],
    this.errorMessage,
  });

  final CollectionStatus status;
  final List<Collection> collections;
  final String? errorMessage;

  CollectionState copyWith({
    CollectionStatus? status,
    List<Collection>? collections,
    String? errorMessage,
  }) {
    return CollectionState(
      status: status ?? this.status,
      collections: collections ?? this.collections,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, collections, errorMessage];
}
