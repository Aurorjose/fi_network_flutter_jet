import '../../abstract_repository/product/product_repository_interface.dart';
import '../../model/product/product.dart';
import '../../utils/pagination.dart';

/// Use case that lists and retuns a list of products.
class ListProductsUseCase {
  /// The repository.
  final ProductRepositoryInterface _repository;

  /// The pagination object.
  late Pagination _pagination;

  /// Exposes whether the list has still elements to be loaded or not.
  bool get canLoadMore => _pagination.canLoadMore;

  /// Creates a new [ListProductsUseCase].
  ListProductsUseCase({
    required ProductRepositoryInterface repository,
    Pagination pagination = const Pagination(),
  })  : _repository = repository,
        _pagination = pagination;

  /// Lists and returns a list of products.
  Future<(int, List<Product>)> call({
    bool loadMore = false,
  }) async {
    _pagination = _pagination.paginate(loadMore: loadMore);

    final (int totalElements, List<Product> productList) =
        await _repository.list(
      limit: _pagination.limit,
      page: _pagination.page,
    );

    _pagination = _pagination.refreshCanLoadMore(
      loadedCount: productList.length,
    );

    return (totalElements, productList);
  }
}
