import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/model/product/product.dart';
import '../../../domain_layer/use_case/product/list_products_use_case.dart';
import 'product_list_state.dart';

/// Cubit that handles the states for the [ProductListScreen].
class ProductListCubit extends Cubit<ProductListState> {
  /// The use case used for listing products.
  final ListProductsUseCase _listProductsUseCase;

  /// Creates a new [ProductListCubit].
  ProductListCubit({
    required ListProductsUseCase listProductsUseCase,
  })  : _listProductsUseCase = listProductsUseCase,
        super(ProductListState());

  Future<void> list({
    bool loadMore = false,
  }) async {
    if (!_listProductsUseCase.canLoadMore ||
        state.actions.contains(ProductListAction.loadingProducts)) {
      return;
    }

    emit(
      state.copyWith(
        actions: state.addAction(
          ProductListAction.loadingProducts,
        ),
        errors: state.removeErrorForAction(
          ProductListAction.loadingProducts,
        ),
      ),
    );

    try {
      final (int totalElements, List<Product> productList) =
          await _listProductsUseCase(
        loadMore: loadMore,
      );

      emit(
        state.copyWith(
          errors: state.removeErrorForAction(
            ProductListAction.loadingProducts,
          ),
          actions: state.removeAction(
            ProductListAction.loadingProducts,
          ),
          totalElements: totalElements,
          productList:
              !loadMore ? productList : [...state.productList, ...productList],
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          actions: state.removeAction(
            ProductListAction.loadingProducts,
          ),
          errors: state.addErrorFromException(
            action: ProductListAction.loadingProducts,
            exception: e,
          ),
        ),
      );
    }
  }
}
