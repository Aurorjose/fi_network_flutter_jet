import 'product.dart';

/// Model representing a switch board product.
class SwitchBoard extends Product {
  /// Creates a new [SwitchBoard].
  const SwitchBoard({
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
