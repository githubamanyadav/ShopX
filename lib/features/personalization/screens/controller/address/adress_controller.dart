import 'package:e_commerce/data/repository/address/address_repository.dart';
import 'package:e_commerce/features/personalization/models/address/address_model.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// snackbar helpers

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  /// Variables
  final _repository = Get.put(AddressRepository());
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  Future<void> addNewAddress() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog();

      // 1. Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // 2. Validate the form with addressFormKey.currentState!.validate()
      if (!addressFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }
      // 3. Build an AddressModel from the text controllers
      AddressModel address = AddressModel(
        id: " ",
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
      );
      // 4. Save it to Firestore through your address repository

      final id = await _repository.addAddress(address);
      address.id = id;
      // 5. Stop the loader and show a success
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.successSnackBar(
        title: "Congratulations",
        message: "your address has been saved successfully",
      );
      resetFormFields();
      Get.back(); 
    } catch (e) {
      // Stop the loader and show the error
      UFullScreenLoader.stopLoading();
      // Show an error snackbar here, e.g. with e.toString()
      USnackBarHelpers.errorSnackBar(title: e.toString());
    }
  }

  // to empty all the controllers fields of the new address form
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();

    addressFormKey.currentState!.reset();
  }

  //to get all the address to the specific user related
  Future<List<AddressModel>> getAllAddress() async {
    try {
      List<AddressModel> addresses = await _repository.fetchUserAddresses();
      return addresses;
    } catch (e) {
      // Show an error snackbar here, e.g. with e.toString()
      USnackBarHelpers.errorSnackBar(title: e.toString());
      return [];
    }
  }
}
