import 'package:fi_network_flutter_jet/domain_layer/model/product/fijo.dart';
import 'package:fi_network_flutter_jet/domain_layer/model/product/tv_product.dart';

import '../../../domain_layer/model/product/fiber.dart';
import '../../../domain_layer/model/product/phone_line.dart';
import '../../../domain_layer/model/product/product.dart';
import '../../../domain_layer/model/product/switch_board.dart';
import '../../dto/product/product_dto.dart';

/// Mapping extensions for the [ProductDTO] object.
extension ProductDTOMapping on ProductDTO {
  /// Maps a [ProductDTO] into a [Product].
  Product toModel() {
    return switch (typeDTO) {
      ProductTypeDTO.fiber => Fiber(
          id: id,
          displayName: displayName,
          name: name,
          description: description,
          type: typeDTO?.toEnum(),
          price: price,
          created: created,
          updated: updated,
          fiberUploadSpeed: fiberDownloadSpeed,
          fiberDownloadSpeed: fiberDownloadSpeed,
          fiberTechnology: fiberTechnology,
        ),
      ProductTypeDTO.phoneLine => PhoneLine(
          id: id,
          displayName: displayName,
          name: name,
          description: description,
          type: typeDTO?.toEnum(),
          price: price,
          created: created,
          updated: updated,
          phoneLineMegas: phoneLineMegas,
          phoneLineMinutes: phoneLineMinutes,
          phoneLineSms: phoneLineSms,
        ),
      ProductTypeDTO.switchBoard => SwitchBoard(
          id: id,
          displayName: displayName,
          name: name,
          description: description,
          type: typeDTO?.toEnum(),
          price: price,
          created: created,
          updated: updated,
        ),
      ProductTypeDTO.tv => TVProduct(
          id: id,
          displayName: displayName,
          name: name,
          description: description,
          type: typeDTO?.toEnum(),
          price: price,
          created: created,
          updated: updated,
        ),
      ProductTypeDTO.fijo => Fijo(
          id: id,
          displayName: displayName,
          name: name,
          description: description,
          type: typeDTO?.toEnum(),
          price: price,
          created: created,
          updated: updated,
          phoneLineMinutes: phoneLineMinutes,
          phoneLineSms: phoneLineSms,
        ),
      _ => Product(
          id: id,
          displayName: displayName,
          name: name,
          description: description,
          type: typeDTO?.toEnum(),
          price: price,
          created: created,
          updated: updated,
        ),
    };
  }
}

/// Mapping extensions for the [ProductTypeDTO] enum.
extension ProductTypeDTOMapping on ProductTypeDTO {
  /// Maps a [ProductTypeDTO] into a [ProductType].
  ProductType toEnum() {
    return switch (this) {
      ProductTypeDTO.fiber => ProductType.fiber,
      ProductTypeDTO.phoneLine => ProductType.phoneLine,
      ProductTypeDTO.switchBoard => ProductType.switchBoard,
      ProductTypeDTO.tv => ProductType.tv,
      ProductTypeDTO.fijo => ProductType.fijo,
      _ => ProductType.unknown,
    };
  }
}
