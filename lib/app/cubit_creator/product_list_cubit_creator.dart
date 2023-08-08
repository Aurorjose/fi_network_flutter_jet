import '../../data_layer/repository/product/product_repository.dart';
import '../../domain_layer/use_case/product/list_products_use_case.dart';
import '../../presentation_layer/cubit/product_list/product_list_cubit.dart';

/// A creator responsible for creating the product list cubit.
class ProductListCubitCreator {
  final ProductRepository _repository;

  /// Creates [ProductListCubitCreator].
  ProductListCubitCreator({
    required ProductRepository repository,
  }) : _repository = repository;

  /// Creates a cubit for the product list screen.
  ProductListCubit create() => ProductListCubit(
        listProductsUseCase: ListProductsUseCase(
          repository: _repository,
        ),
      );
}
