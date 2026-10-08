import 'package:e_commerce/features/authentication/screens/Login/login_screen.dart';
import 'package:e_commerce/features/authentication/screens/forget_password.dart/forget_password.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/on_boarding.dart';
import 'package:e_commerce/features/authentication/screens/signup/email_verify.dart';
import 'package:e_commerce/features/personalization/screens/address/add_new_adress.dart';
import 'package:e_commerce/features/personalization/screens/edit%20profile/edit_profile.dart';
import 'package:e_commerce/features/personalization/screens/profile.dart';
import 'package:e_commerce/features/shop/screens/order/orders.dart';
import 'package:e_commerce/features/shop/screens/store/screens/store.dart';
import 'package:e_commerce/features/shop/screens/wishlist/wishlist.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/routes/routes.dart';
import 'package:get/get.dart';

import '../features/authentication/screens/signup/signup.dart';

import '../features/shop/screens/cart/cart.dart';
import '../features/shop/screens/checkout/checkout.dart';

class UAppRoutes {
  static final screens = [
    GetPage(name: URoutes.home, page: () => const NavigationMenu()),
    GetPage(name: URoutes.store, page: () => const StoreScreen()),
    GetPage(name: URoutes.wishlist, page: () => const Wishlist()),
    GetPage(name: URoutes.profile, page: () => const Profile()),
    GetPage(name: URoutes.order, page: () => const OrdersScreen()),
    GetPage(name: URoutes.checkout, page: () => const CheckoutScreen()),
    GetPage(name: URoutes.cart, page: () => const CartScreen()),
    GetPage(name: URoutes.editProfile, page: () => const EditProfile()),
    GetPage(name: URoutes.userAddress, page: () => const AddNewAdress()),
    GetPage(name: URoutes.signup, page: () => const SignIn()),
    GetPage(name: URoutes.verifyEmail, page: () => const EmailVerifyScreen()),
    GetPage(name: URoutes.signIn, page: () => LoginScreen()),
    GetPage(name: URoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: URoutes.onBoarding, page: () => const OnBoarding()),
  ];
}
