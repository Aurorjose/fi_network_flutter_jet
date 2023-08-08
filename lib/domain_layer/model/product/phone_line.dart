import 'product.dart';

/// Model representing a phone line product.
class PhoneLine extends Product {
  /// The amount of megas available.
  final int? phoneLineMegas;

  /// The amount of minutes available.
  final int? phoneLineMinutes;

  /// The amount of SMS availalbe.
  final int? phoneLineSms;

  /// Creates a new [PhoneLine].
  const PhoneLine({
    super.id,
    super.displayName,
    super.name,
    super.description,
    super.type,
    super.price,
    super.created,
    super.updated,
    this.phoneLineMegas,
    this.phoneLineMinutes,
    this.phoneLineSms,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        phoneLineMegas,
        phoneLineMinutes,
        phoneLineSms,
      ];
}
