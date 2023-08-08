import '../../model/product/product.dart';

/// The abstract repository for the products.
abstract class ProductRepositoryInterface {
  /// Retrieves a list of products.
  ///
  /// The first returned value represents the total amount of products,
  /// the second, is the list of products that was listed.
  Future<(int, List<Product>)> list({
    required int limit,
    required int page,
  });
}
