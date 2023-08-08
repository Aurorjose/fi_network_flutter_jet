import 'product.dart';

/// Model representing a fiber product.
class Fiber extends Product {
  /// The upload speed in Mbps.
  final int? fiberUploadSpeed;

  /// The download speed in Mbps.
  final int? fiberDownloadSpeed;

  /// This fiber technology.
  final String? fiberTechnology;

  /// Creates a new [Fiber].
  const Fiber({
    super.id,
    super.displayName,
    super.name,
    super.description,
    super.type,
    super.price,
    super.created,
    super.updated,
    this.fiberUploadSpeed,
    this.fiberDownloadSpeed,
    this.fiberTechnology,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        fiberUploadSpeed,
        fiberDownloadSpeed,
        fiberTechnology,
      ];
}
