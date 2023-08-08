import 'package:fi_network_flutter_jet/app/resources/test_localizations.dart';

import '../../domain_layer/model/product/product.dart';

extension ProductUIExtensions on Product {
  String get localizedType {
    return switch (type) {
      ProductType.fiber => TestLocalizations.fibra,
      ProductType.phoneLine => TestLocalizations.lineaMovil,
      ProductType.switchBoard => TestLocalizations.switchBoard,
      ProductType.tv => TestLocalizations.tv,
      ProductType.fijo => TestLocalizations.fijo,
      _ => TestLocalizations.uknown,
    };
  }
}
