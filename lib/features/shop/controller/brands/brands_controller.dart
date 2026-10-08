import 'package:e_commerce/data/repository/brand/brand_repository.dart';

import 'package:e_commerce/features/shop/models/brands/brands_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';

import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  /// Variables
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  /// Get All Brands And Featured Brands
  Future<void> getBrands() async {
    try {
      isLoading.value = true;
      List<BrandModel> allBrands = await _repository.fetchBrands();

      this.allBrands.assignAll(allBrands);

      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4).toList(),
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
