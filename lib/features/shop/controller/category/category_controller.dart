import 'package:e_commerce/data/repository/category_repository.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  /// Variables
  final isCategoriesLoading = false.obs;
  final _repository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    //fetchCategories get called automatically after get.put()
    fetchCategories();
    super.onInit();
  }

  /// Function to get all categories & featured categories from Firebase
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isCategoriesLoading.value = true;

      //
      // _repository.uploadBrandCategory(brandCategories);
      // Fetch categories from the repository
      List<CategoryModel> categories = await _repository.getAllCategories();

      // Update the observable lists -> allCategories
      allCategories.assignAll(categories);
      // Update the observable lists -> FeaturedCategories
      featuredCategories.assignAll(
        categories.where(
          (category) => category.isFeatured && category.parentId.isEmpty,
        ),
      );
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      // Remove loader
      isCategoriesLoading.value = false;
    }
  }
}
