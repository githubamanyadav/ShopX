import 'package:e_commerce/features/shop/controller/product/variation_controller.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:get/instance_manager.dart';

//bindings are used to intialze the things in the app which are important intially
class UBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
  }
}
