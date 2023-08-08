import 'product.dart';

/// Model representing a tv product.
class TVProduct extends Product {
  /// Creates a new [TVProduct].
  const TVProduct({
    super.id,
    super.displayName,
    super.name,
    super.description,
    super.type,
    super.price,
    super.created,
    super.updated,
  });
}
