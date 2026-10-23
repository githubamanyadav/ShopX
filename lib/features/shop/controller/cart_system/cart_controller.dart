import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/shop/controller/product/variation_controller.dart';
import 'package:e_commerce/features/shop/models/cart_system/cart_item_model.dart';
import 'package:e_commerce/features/shop/models/products/product_variation.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/enums.dart';
import 'package:e_commerce/utils/constants/keys.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  /// Variables
  final _storage = GetStorage(
    AuthenticationRepository.instance.currentUser!.uid,
  );
  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  //intailizing the local storage value
  @override
  void onInit() {
    super.onInit();
  }

  //loading the cart items from local storage
  CartController() {
    List<dynamic>? storedCartItems = _storage.read(Ukeys.cartItemsKey);
    if (storedCartItems != null) {
      cartItems.assignAll(
        storedCartItems.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCart();
    }
  }

  final variationController = VariationController.instance;
  //if the user just add one item by just tapping on plus icon
  void addToOneCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );

    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  //remove item by one time only
  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          item.productId == cartItem.productId &&
          item.variationId == cartItem.variationId,
    );

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
    }
  }

  //
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure you want to remove this product?',
      onConfirm: () {
        cartItems.removeAt(index);

        updateCart();
        USnackBarHelpers.customToast(message: 'Product removed from the cart');
        Get.back(); // incomplete in the video; the presenter was still typing this line
      },
      onCancel: () {},
    );
  }

  //get total quantity of same specific product
  int getProductQuantityInCart(String productId) {
    final item = cartItems
        .where((cartItem) => cartItem.productId == productId)
        .fold(
          0,
          (previousValue, cartItem) => previousValue + cartItem.quantity,
        );

    return item;
  }

  /// Add Items in the cart
  void addToCart(ProductModel product) {
    // Check quantity of the product
    if (productQuantityInCart < 1) {
      USnackBarHelpers.customToast(message: 'Select Quantity');
      return;
    }
    // if the product have the variation then check variations are selected
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      return USnackBarHelpers.customToast(message: "select Variation");
    }
    //check the product is out of stock
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        USnackBarHelpers.warningSnackBar(title: "product is out of stock");
        return;
      } else {
        if (product.stock < 1) {
          USnackBarHelpers.warningSnackBar(
            title: 'Out of stock',
            message: "This product is out of stock",
          );
        }
      }
    }
    //conversion productitem mdoel to cartItemModel with given qunatity
    CartItemModel selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );
    //check if already added in the cart
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          selectedCartItem.variationId == cartItem.variationId,
    );
    //if yes then update the quantity
    if (index >= 0) {
      //this quantity is already added or updated /removed from teh cart
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }
    //
  }

  //convert product item to cartItem
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      //reset the variation if the product type is single

      variationController.resetSelectedAttributes();
    }

    ProductVariationModel variation =
        variationController.selectedVariation.value;

    bool isVariation = variation.id.isNotEmpty;
    String image = isVariation ? variation.image : product.thumbnail;
    double price = isVariation
        ? variation.salePrice > 0.0
              ? variation.salePrice
              : product.price
        : product.salePrice > 0.0
        ? product.salePrice
        : product.price;

    return CartItemModel(
      productId: product.id,
      quantity: quantity,
      title: product.title,
      brandName: product.brand != null ? product.brand!.name : "",
      image: image,
      price: price,
      selectedVariation: isVariation ? variation.attributeValues : null,
      variationId: variation.id,
    );
  }

  //calculating the total price in the cart & total no of items
  void updateCartTotals() {
    double calculateTotalPrice = 0.0;
    int calculateNoOfitems = 0;

    for (final item in cartItems) {
      calculateTotalPrice += item.price * item.quantity.toDouble();
      calculateNoOfitems += item.quantity;
    }
    totalCartPrice.value = calculateTotalPrice;
    noOfCartItems.value = calculateNoOfitems;
  }

  //saving cart item to local storage
  void saveCartitems() {
    List<Map<String, dynamic>> cartItemList = cartItems
        .map((items) => items.toJson())
        .toList();
    _storage.write(Ukeys.cartItemsKey, cartItemList);
  }

  //updations
  void updateCart() {
    updateCartTotals();
    saveCartitems();
    cartItems.refresh();
  }

  //clear the cart
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  //get quantity of a specific variation of a product
  int getVaraitionQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  //
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      String variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVaraitionQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }
}
