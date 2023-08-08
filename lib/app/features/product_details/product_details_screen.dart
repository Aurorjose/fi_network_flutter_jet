import 'package:fi_network_flutter_jet/app/widgets/products/product_tile_widget.dart';
import 'package:fi_network_flutter_jet/domain_layer/model/product/fijo.dart';
import 'package:fi_network_flutter_jet/domain_layer/model/product/phone_line.dart';
import 'package:flutter/material.dart';

import '../../../domain_layer/model/product/fiber.dart';
import '../../../domain_layer/model/product/product.dart';
import '../../resources/test_colors.dart';
import '../../resources/test_localizations.dart';
import '../../resources/test_text_styles.dart';

/// A screen that shows the details for the passed product.
class ProductDetailsScreen extends StatelessWidget {
  /// The product.
  final Product product;

  /// Creates a new [ProductDetailsScreen].
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: TestColors.primary,
          title: Text(
            product.displayName ?? '',
            style: TestTextStyles.appBar,
          ),
        ),
        backgroundColor: TestColors.secondary,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductTileWidget(product: product),
              const SizedBox(height: 20.0),
              Text(
                TestLocalizations.detallesGenerales,
                style: TestTextStyles.mainTitle,
              ),
              const SizedBox(height: 20.0),
              _buildDetailRow(
                title: TestLocalizations.id,
                description: product.id.toString(),
              ),
              _buildDetailRow(
                title: TestLocalizations.nombreTecnico,
                description: product.name,
              ),
              _buildDetailRow(
                title: TestLocalizations.precio,
                description: product.price.toString(),
              ),
              _buildDetailRow(
                title: TestLocalizations.fechaCreacion,
                description: product.created.toString(),
              ),
              _buildDetailRow(
                title: TestLocalizations.ultimaActualizacion,
                description: product.updated.toString(),
              ),
              const SizedBox(height: 20.0),
              Text(
                TestLocalizations.detallesDelProducto,
                style: TestTextStyles.mainTitle,
              ),
              const SizedBox(height: 20.0),
              _buildProductDetails(),
            ],
          ),
        ),
      );

  /// Builds the row for a product detail.
  Widget _buildDetailRow({
    required String title,
    String? description,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title:'),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Text(
              description ?? '-',
              textAlign: TextAlign.end,
            ),
          )
        ],
      );

  Widget _buildProductDetails() {
    final List<Widget> detailList = <Widget>[];

    switch (product.runtimeType) {
      case Fiber:
        final fiberProduct = product as Fiber;
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.velocidadDeSubida,
            description: fiberProduct.fiberUploadSpeed.toString(),
          ),
        );
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.velocidadDeDescarga,
            description: fiberProduct.fiberDownloadSpeed.toString(),
          ),
        );
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.tecnologiaDeLaFibra,
            description: fiberProduct.fiberTechnology.toString(),
          ),
        );

      case PhoneLine:
        final phoneLineProduct = product as PhoneLine;
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.cantidadDeMegas,
            description: phoneLineProduct.phoneLineMegas.toString(),
          ),
        );
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.cantidadDeMinutos,
            description: phoneLineProduct.phoneLineMinutes.toString(),
          ),
        );
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.cantidadDeSms,
            description: phoneLineProduct.phoneLineSms.toString(),
          ),
        );

      case Fijo:
        final fijoProduct = product as Fijo;
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.cantidadDeMinutos,
            description: fijoProduct.phoneLineMinutes.toString(),
          ),
        );
        detailList.add(
          _buildDetailRow(
            title: TestLocalizations.cantidadDeSms,
            description: fijoProduct.phoneLineSms.toString(),
          ),
        );

      default:
        detailList.add(
          const Text(TestLocalizations.uknown),
        );
    }

    return Column(
      children: detailList,
    );
  }
}
