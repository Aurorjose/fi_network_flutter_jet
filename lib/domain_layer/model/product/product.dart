import 'package:equatable/equatable.dart';

/// The product type of a product.
enum ProductType {
  /// Fiber.
  fiber,

  /// Phone line.
  phoneLine,

  /// Switch board.
  switchBoard,

  /// TV.
  tv,

  /// Fijo.
  fijo,

  /// Unknown.
  unknown,
}

/// A model representing a product.
class Product extends Equatable {
  /// The product id.
  final int? id;

  /// The name to display for this product.
  final String? displayName;

  /// The technical name for this product.
  final String? name;

  /// The description for this product.
  final String? description;

  /// The product type.
  final ProductType? type;

  /// The price.
  final double? price;

  /// The date this product was created.
  final DateTime? created;

  /// The date this product was last updated.
  final DateTime? updated;

  /// Creates a new [Product].
  const Product({
    this.id,
    this.displayName,
    this.name,
    this.description,
    this.type,
    this.price,
    this.created,
    this.updated,
  });

  @override
  List<Object?> get props => [
        id,
        displayName,
        name,
        description,
        type,
        price,
        created,
        updated,
      ];
}
