import 'package:fi_network_flutter_jet/data_layer/helpers/json_parser.dart';
import 'package:fi_network_flutter_jet/data_layer/network/endpoints.dart';
import 'package:fi_network_flutter_jet/data_layer/network/network_client.dart';

import '../../dto/product/product_dto.dart';

class ProductProvider {
  /// The network client used for the API requests.
  final NetworkClient _networkClient;

  /// Creates a new [ProductProvider].
  ProductProvider({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;

  /// Gets a list of products and returns the total amount of products and the
  /// requested list.
  Future<(int, List<ProductDTO>)> list({
    required int limit,
    required int page,
  }) async {
    final response = await _networkClient.get(
      Endpoints.products,
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );

    final totalElements = response.data['page'] == null
        ? '0'
        : response.data['page']['totalElements'].toString();

    return (
      JsonParser.parseInt(totalElements) ?? 0,
      ProductDTO.fromJsonList(
        List<Map<String, dynamic>>.from(
          response.data['_embedded']['products'],
        ),
      )
    );
  }
}
