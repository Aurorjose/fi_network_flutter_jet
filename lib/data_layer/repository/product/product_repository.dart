import '../../../domain_layer/abstract_repository/product/product_repository_interface.dart';
import '../../../domain_layer/model/product/product.dart';
import '../../dto/product/product_dto.dart';
import '../../mapping/product/product_dto_mapping.dart';
import '../../provider/product/product_provider.dart';

/// Handles the data for the [Product]s.
class ProductRepository implements ProductRepositoryInterface {
  /// The product provider.
  final ProductProvider _provider;

  /// Creates a new [ProductRepository].
  const ProductRepository({
    required ProductProvider provider,
  }) : _provider = provider;

  /// Retrieves a list of products.
  @override
  Future<(int, List<Product>)> list({
    required int limit,
    required int page,
  }) async {
    final (int totalElements, List<ProductDTO> productDTOList) =
        await _provider.list(
      limit: limit,
      page: page,
    );

    final productList = productDTOList.map((e) => e.toModel()).toList();

    return (totalElements, productList);
  }
}
