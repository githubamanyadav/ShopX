import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce/utils/popups/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();

  /// Subscription to the connectivity stream.
  /// Note: connectivity_plus now emits a List<ConnectivityResult> instead of a
  /// single ConnectivityResult, since a device can be connected to more than
  /// one network at the same time (e.g. WiFi + mobile data).
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  /// Holds the current connectivity status as a reactive list.
  final Rx<List<ConnectivityResult>> _connectionStatus =
      Rx<List<ConnectivityResult>>([ConnectivityResult.none]);

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    // Listen to connectivity changes; fires every time the network state changes.
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    // Store the latest list of active connection types.
    _connectionStatus.value = result;

    // If "none" is present in the list, there is no active internet connection.
    if (_connectionStatus.value.contains(ConnectivityResult.none)) {
      USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');
    }
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      // checkConnectivity() also returns a List<ConnectivityResult> now.
      final result = await _connectivity.checkConnectivity();

      // Connected as long as "none" is not among the active connection types.
      return !result.contains(ConnectivityResult.none);
    } on PlatformException catch (_) {
      // If checking connectivity fails at the platform level, treat as disconnected.
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
