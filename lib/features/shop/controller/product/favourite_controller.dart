import 'dart:convert';

import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/data/repository/product/product_repository.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteController extends GetxController {
  // Must be a getter, not a static field. Get.find() would run too early otherwise.
  static FavouriteController get instance => Get.find();

  /// Variables

  final favourites = <String, bool>{}.obs;
  //this will create local stroage according to the name of the user id & each different user in the same device will get the diff local storage to keep the sepration from each other
  final _storage = GetStorage(
    AuthenticationRepository.instance.currentUser!.uid,
  );

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  /// Load saved favourites from local storage
  Future<void> initFavourites() async {
    final json = _storage.read('favourites');

    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      //removing the empty value in the map and give a
      final cleaned = Map<String, bool>.from(
        storedFavourites.map((key, value) => MapEntry(key, value as bool)),
      )..removeWhere((key, value) => key.isEmpty); // 🔑 remove bad entries

      favourites.assignAll(cleaned);

      // Persist the cleaned version back so it doesn't keep loading garbage
      saveFavouritesToStorage();
    }
  }

  /// Check if a product is a favourite
  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  /// Add or remove a product from favourites
  void toggleFavouriteProduct(String productId) {
    if (productId.isEmpty) return;

    /// if there is no product realted to product id
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavouritesToStorage();

      // Optional: show a "Added to wishlist" message here
      USnackBarHelpers.customToast(message: " product added to the wishlist");
    } else {
      favourites.remove(productId);
      saveFavouritesToStorage();
      USnackBarHelpers.customToast(
        message: " prodcut removed from the wishlist",
      );
      favourites.refresh();
      // Optional: show a "Removed from wishlist" message here
    }
  }

  /// Save the current favourites map to local storage
  void saveFavouritesToStorage() {
    //convert favourite Map() into a json format to save the json data into storage
    final encodedFavourites = jsonEncode(favourites);
    _storage.write('favourites', encodedFavourites);
  }

  //to get all the favourite products from the firebase
  Future<List<ProductModel>> getFavouriteProducts() async {
    final productIds = favourites.keys.toList();
    if (productIds.isEmpty) return [];
    return await ProductRepository.instance.getFavouriteProducts(productIds);
  }
}
