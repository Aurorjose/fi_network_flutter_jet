import 'package:fi_network_flutter_jet/app/extensions/product_ui_extensions.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/model/product/product.dart';
import '../../navigation/navigation_configuration.dart';
import '../../resources/test_colors.dart';
import '../../resources/test_text_styles.dart';

/// Tile widget that shows the basic details for the passed [Product] object.
class ProductTileWidget extends StatelessWidget {
  /// The product object.
  final Product product;

  /// Creates a new [ProductTileWidget].
  const ProductTileWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.pushNamed(
          context,
          Screens.productDetails,
          arguments: product,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: TestColors.primary,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: TestColors.secondary.withOpacity(0.7),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        product.localizedType,
                        style: TestTextStyles.mainTitle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${product.id} - ${product.displayName}',
                      style: TestTextStyles.productTitleAccent,
                    ),
                    if (product.description != null)
                      Text(
                        product.description!,
                        style: TestTextStyles.productDescriptionAccent,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
