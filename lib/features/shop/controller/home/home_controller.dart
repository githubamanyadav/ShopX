import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  //vairables
  final carouselController = CarouselSliderController();

  RxInt currentIndex = 0.obs;

  void onPageChange(int index) {
    currentIndex.value = index;
  }
}
