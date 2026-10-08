import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  /// Variables
  final _repository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    getFeaturedProduct();
    super.onInit();
  }

  /// Function to get only 4 featured products
  Future<void> getFeaturedProduct() async {
    try {
      List<ProductModel> featuredProducts = await _repository
          .fetchFeaturedProducts();
      this.featuredProducts.assignAll(featuredProducts);
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }
  }

  //how much sales on a product in %
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0.0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;

    return percentage.toStringAsFixed(1);
  }

  /// Get the product price or price range for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // If no variation exists, return the single price or sale price
    if (product.productType == ProductType.single.toString()) {
      return product.salePrice > 0
          ? product.salePrice.toString()
          : product.price.toString();
    } else {
      // Calculate the smallest and largest price among variations
      for (final variation in product.productVariations!) {
        double variationPrice = variation.salePrice > 0
            ? variation.salePrice
            : variation.price;

        if (variationPrice > largestPrice) {
          largestPrice = variationPrice;
        }

        if (variationPrice < smallestPrice) {
          smallestPrice = variationPrice;
        }
      }

      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${UTexts.currency}${smallestPrice.toStringAsFixed(0)} - ${UTexts.currency}${largestPrice.toStringAsFixed(0)}';
      }
    }
  }

  //\
  String getStockStatus(int stock) {
    if (stock > 0) return "In Stock";
    return "Out of Stock";
  }
}
