import 'package:equatable/equatable.dart';

/// A helper widget that keeps the basic data needed for pagination.
class Pagination extends Equatable {
  /// Maximum number of items to load at a time.
  final int limit;

  /// The current page.
  final int page;

  /// If there is more data to be loaded.
  final bool canLoadMore;

  /// Creates a new [Pagination] with the default values.
  const Pagination({
    this.limit = 20,
    this.page = 1,
    this.canLoadMore = true,
  });

  @override
  List<Object?> get props => [
        limit,
        page,
        canLoadMore,
      ];

  /// Returns `true` if the it's on the first page.
  bool get firstPage => page == 1;

  /// Returns a new [Pagination] with the updated page index.
  ///
  /// If [loadMore] is false, then it sets the page to 1.
  Pagination paginate({
    required bool loadMore,
  }) =>
      copyWith(
        page: loadMore ? page + 1 : 1,
      );

  /// Returns a new [Pagination] with the updated [canLoadMore], based on
  /// how many items were loaded -- given by the [loadedCount] parameter.
  Pagination refreshCanLoadMore({
    required int loadedCount,
  }) =>
      copyWith(
        canLoadMore: loadedCount >= limit,
      );

  /// Creates a new object based on this one.
  Pagination copyWith({
    int? limit,
    int? page,
    bool? canLoadMore,
  }) =>
      Pagination(
        limit: limit ?? this.limit,
        page: page ?? this.page,
        canLoadMore: canLoadMore ?? this.canLoadMore,
      );
}
