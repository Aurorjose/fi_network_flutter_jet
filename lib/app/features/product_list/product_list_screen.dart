import 'package:fi_network_flutter_jet/app/resources/test_colors.dart';
import 'package:fi_network_flutter_jet/app/resources/test_text_styles.dart';
import 'package:fi_network_flutter_jet/presentation_layer/cubit/product_list/product_list_state.dart';
import 'package:fi_network_flutter_jet/presentation_layer/widgets/cubit_helper/cubit_action_builder.dart';
import 'package:fi_network_flutter_jet/presentation_layer/widgets/cubit_helper/cubit_error_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/model/product/product.dart';
import '../../../presentation_layer/cubit/product_list/product_list_cubit.dart';
import '../../resources/test_localizations.dart';
import '../../widgets/products/product_tile_widget.dart';

/// Screen for showing the list of products.
class ProductListScreen extends StatefulWidget {
  /// Creates a new [ProductListScreen].
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scrollController = ScrollController();

  bool _isErrorShowing = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductListCubit>().list();

    _scrollController.addListener(() {
      double offsetBottom =
          _scrollController.position.maxScrollExtent - _scrollController.offset;

      if (offsetBottom < 200) {
        context.read<ProductListCubit>().list(
              loadMore: true,
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      CubitErrorListener<ProductListCubit, ProductListAction>(
        actions: const {ProductListAction.loadingProducts},
        onAPIError: (error) => _showErrorDialog(
          title: TestLocalizations.appTitle,
          description: error.message,
        ),
        onConnectivityError: (_) => _showErrorDialog(
          title: TestLocalizations.connectivityError,
          description: TestLocalizations.connectivityErrorDescription,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: TestColors.primary,
            title: Text(
              TestLocalizations.appTitle,
              style: TestTextStyles.appBar,
            ),
          ),
          backgroundColor: TestColors.secondary,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 16.0,
            ),
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TestLocalizations.listadoDeProductos,
                  style: TestTextStyles.mainTitle,
                ),
                const SizedBox(height: 20.0),
                CubitActionBuilder<ProductListCubit, ProductListAction>(
                  actions: const {ProductListAction.loadingProducts},
                  builder: (context, loadingActions) {
                    final productList =
                        context.select<ProductListCubit, List<Product>>(
                      (cubit) => cubit.state.productList,
                    );

                    return Column(
                      children: [
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ProductTileWidget(
                            product: productList[index],
                          ),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 5.0),
                          itemCount: productList.length,
                        ),
                        if (loadingActions.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                TestColors.primary,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

  /// Shows an error dialog. When it closes, it reloads the product list.
  Future<void> _showErrorDialog({
    required String title,
    String? description,
  }) async {
    if (_isErrorShowing) {
      return;
    }

    _isErrorShowing = true;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: description == null ? null : Text(description),
        actions: <Widget>[
          TextButton(
            child: const Text(TestLocalizations.tryAgain),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ).then(
      (_) {
        _isErrorShowing = false;
        context.read<ProductListCubit>().list();
      },
    );
  }
}
