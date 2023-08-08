import 'package:fi_network_flutter_jet/data_layer/network/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/cubit_creator/product_list_cubit_creator.dart';
import 'app/navigation/navigation_configuration.dart';
import 'data_layer/network/network_client.dart';
import 'data_layer/provider/product/product_provider.dart';
import 'data_layer/repository/product/product_repository.dart';

void main() => runApp(FiNetworkTechnicalTestApp());

class FiNetworkTechnicalTestApp extends StatelessWidget {
  late final NavigationConfiguration _navigationConfiguration;

  late final NetworkClient _networkClient;

  late final ProductProvider _productProvider;
  late final ProductRepository _productRepository;

  FiNetworkTechnicalTestApp({super.key}) {
    _navigationConfiguration = NavigationConfiguration();

    _networkClient = NetworkClient(baseURL: Endpoints.baseUrl);

    _productProvider = ProductProvider(networkClient: _networkClient);
    _productRepository = ProductRepository(provider: _productProvider);
  }

  @override
  Widget build(BuildContext context) => Provider<ProductListCubitCreator>(
        create: (context) => ProductListCubitCreator(
          repository: _productRepository,
        ),
        child: MaterialApp(
          initialRoute: _navigationConfiguration.initialRoute,
          onGenerateRoute: _navigationConfiguration.onGenerateRoute,
        ),
      );
}
