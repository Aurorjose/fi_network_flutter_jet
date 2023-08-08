import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain_layer/model/product/product.dart';
import '../../presentation_layer/cubit/product_list/product_list_cubit.dart';
import '../cubit_creator/product_list_cubit_creator.dart';
import '../features/product_details/product_details_screen.dart';
import '../features/product_list/product_list_screen.dart';

/// A configuration class that defines the initial route
/// and defines how routes are generated.
class NavigationConfiguration {
  String get initialRoute => Screens.productList;

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Keep this alphabetized

      case Screens.productDetails:
        return MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            product: settings.arguments as Product,
          ),
          settings: settings,
        );

      case Screens.productList:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ProductListCubit>(
            create: (context) =>
                context.read<ProductListCubitCreator>().create(),
            child: const ProductListScreen(),
          ),
          settings: settings,
        );

      default:
        throw UnsupportedError('Route ${settings.name} is not supported');
    }
  }
}

/// A class that keeps track of all available route names.
abstract class Screens {
  // Keep this alphabetized

  /// The product details screen.
  static const String productDetails = 'productDetails';

  /// The product list screen.
  static const String productList = 'productList';
}
