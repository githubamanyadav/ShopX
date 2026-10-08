import 'package:e_commerce/data/repository/banner/banner_repository.dart';
import 'package:e_commerce/features/shop/models/banner/banner_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  /// Variables
  final _repository = Get.put(BannerRepository());
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  /// Fetch All Banners
  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      List<BannerModel> activeBanners = await _repository.fetchActiveBanners();
      banners.assignAll(activeBanners);
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
