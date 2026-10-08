import 'package:e_commerce/features/shop/controller/product/image_controller.dart';
import 'package:e_commerce/features/shop/models/products/product_variation.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs; // {'Color' : ['Blue', 'Green', 'Red']}
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;
  RxString variationStockStatus = ''.obs;

  /// Select Attribute And Variation
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    // When attribute is selected we will first add that attribute to the selectedAttributes
    Map<String, dynamic> selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] =
        attributeValue; // selectedAttribute['Color'] : 'Green'

    // get selected variation
    ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
          (variation) => isSameAttributeValues(
            variation.attributeValues,
            selectedAttributes,
          ),
        );

    // Show the selected variation image as main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Assign selected Variation to Rx Variable
    this.selectedVariation(selectedVariation);
    getProductVariationStockStatus();
  }

  /// Check if selected attributes match any variation attributes

  /// Check if selected attributes matches any variation attributes
  bool isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // if selectedAttributes contains 3 attributes and current variation contains 2 then return
    if (variationAttributes.length != selectedAttributes.length) return false;

    // if any of the attribute is different then return ['Green', 'Large'] != ['Green', 'Small']
    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  /// Check Product Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }
}
