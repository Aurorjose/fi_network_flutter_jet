import 'product.dart';

/// Model representing a phone line product.
class Fijo extends Product {
  /// The amount of minutes available.
  final int? phoneLineMinutes;

  /// The amount of SMS availalbe.
  final int? phoneLineSms;

  /// Creates a new [Fijo].
  const Fijo({
    super.id,
    super.displayName,
    super.name,
    super.description,
    super.type,
    super.price,
    super.created,
    super.updated,
    this.phoneLineMinutes,
    this.phoneLineSms,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        phoneLineMinutes,
        phoneLineSms,
      ];
}
