import 'package:collection/collection.dart';

import '../../../domain_layer/model/product/product.dart';
import '../base_state.dart';

/// The actions that the [ProductListCubit] can perform.
enum ProductListAction {
  /// Loading the products.
  loadingProducts,
}

/// The state for the [ProductListCubit].
class ProductListState extends BaseState<ProductListAction> {
  /// The total amount of products.
  final int? totalElements;

  /// List of [Product]s.
  final UnmodifiableListView<Product> productList;

  /// Creates a new instance of [ProductListState]
  ProductListState({
    super.actions,
    super.errors,
    this.totalElements,
    Iterable<Product> productList = const <Product>[],
  }) : productList = UnmodifiableListView(productList);

  @override
  List<Object?> get props => [
        actions,
        errors,
        totalElements,
        productList,
      ];

  /// Creates a copy of this state with the passed values.
  @override
  ProductListState copyWith({
    Set<ProductListAction>? actions,
    Set<CubitError>? errors,
    int? totalElements,
    Iterable<Product>? productList,
  }) =>
      ProductListState(
        actions: actions ?? this.actions,
        errors: errors ?? this.errors,
        totalElements: totalElements ?? this.totalElements,
        productList: productList ?? this.productList,
      );
}
