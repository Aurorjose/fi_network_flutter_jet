import 'package:fi_network_flutter_jet/data_layer/helpers/json_parser.dart';

/// The product type of a product.
enum ProductTypeDTO {
  /// Fiber.
  fiber('FIBERVODAFONE'),

  /// Phone line.
  phoneLine('PHONELINE'),

  /// Switch board.
  switchBoard('SWITCHBOARD'),

  /// TV.
  tv('TV'),

  /// Fijo.
  fijo('TUFIJO'),

  /// unknown.
  unknown('uknown');

  /// The raw value.
  final String value;

  /// Creates new [ProductTypeDTO].
  const ProductTypeDTO(this.value);

  /// Convert string to [ProductTypeDTO].
  static ProductTypeDTO? fromRaw(String? raw) => values.singleWhere(
        (val) => val.value == raw,
        orElse: () => unknown,
      );
}

/// Represents a product as provided by the products endpoint.
class ProductDTO {
  /// The product id.
  int? id;

  /// The name to display for this product.
  String? displayName;

  /// The technical name for this product.
  String? name;

  /// The description for this product.
  String? description;

  /// The product type.
  ProductTypeDTO? typeDTO;

  /// The price.
  double? price;

  /// The upload speed in Mbps in case this product is a fiber.
  int? fiberUploadSpeed;

  /// The download speed in Mbps in case this product is a fiber.
  int? fiberDownloadSpeed;

  /// This product's technology in case this product is a fiber.
  String? fiberTechnology;

  /// The amount of megas available in case this product is a phone line.
  int? phoneLineMegas;

  /// The amount of minutes available in case this product is a phone line.
  int? phoneLineMinutes;

  /// The amount of SMS availalbe in case this product is a phone line.
  int? phoneLineSms;

  /// The date this product was created.
  DateTime? created;

  /// The date this product was last updated.
  DateTime? updated;

  /// Creates a new [ProductDTO]
  ProductDTO({
    this.id,
    this.displayName,
    this.name,
    this.description,
    this.typeDTO,
    this.price,
    this.fiberUploadSpeed,
    this.fiberDownloadSpeed,
    this.fiberTechnology,
    this.phoneLineMegas,
    this.phoneLineMinutes,
    this.phoneLineSms,
    this.created,
    this.updated,
  });

  /// Creates a [ProductDTO] from a JSON object.
  factory ProductDTO.fromJson(Map<String, dynamic> json) => ProductDTO(
        id: JsonParser.parseInt(json['id']?.toString()),
        displayName: json['displayName'],
        name: json['name'],
        description: json['description'],
        typeDTO: ProductTypeDTO.fromRaw(json['type']),
        price: (json['prices'] as List? ?? []).isEmpty
            ? null
            : JsonParser.parseDouble(json['prices'].first['price']?.toString()),
        fiberUploadSpeed:
            JsonParser.parseInt(json['fiberUploadMegas']?.toString()),
        fiberDownloadSpeed:
            JsonParser.parseInt(json['fiberDownloadMegas']?.toString()),
        fiberTechnology: json['fiberTecnology'],
        phoneLineMegas: JsonParser.parseInt(json['phonelineMegas']?.toString()),
        phoneLineMinutes:
            JsonParser.parseInt(json['phonelineMinutes']?.toString()),
        phoneLineSms: JsonParser.parseInt(json['phonelineSms']?.toString()),
        created: JsonParser.parseDate(json['createdAt']?.toString()),
        updated: JsonParser.parseDate(json['updatedAt']?.toString()),
      );

  /// Creates a list of [ProductDTO] from a list of JSON objects.
  static List<ProductDTO> fromJsonList(List<Map<String, dynamic>> json) =>
      json.map(ProductDTO.fromJson).toList(growable: false);
}
