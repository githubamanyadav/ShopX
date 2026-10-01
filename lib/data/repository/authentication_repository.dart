import 'package:e_commerce/data/repository/user/user_repository.dart';
import 'package:e_commerce/features/authentication/screens/login/login_screen.dart';
import 'package:e_commerce/features/authentication/screens/onboarding/on_boarding.dart';

import 'package:e_commerce/features/authentication/screens/signup/email_verify.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/exception/firebase_auth_exception.dart';
import 'package:e_commerce/utils/exception/firebase_exceptions.dart';
import 'package:e_commerce/utils/exception/format_exception.dart';
import 'package:e_commerce/utils/exception/platform_exception.dart';

import 'package:flutter/services.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //vairables needed in the starting of the app
  //
  final _auth = FirebaseAuth.instance;
  final localStorage = GetStorage();
  //this will bring the current login user in the app
  User? get currentUser => _auth.currentUser;

  // this is function will get run just after the main.dart run the authrepository line & this function intialize what ever is in it
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  void screenRedirect() {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => NavigationMenu());
      } else {
        Get.offAll(() => EmailVerifyScreen());
      }
    } else {
      localStorage.writeIfNull("isFirstTime", true);
      localStorage.read('isFirstTime') == true
          ? Get.to(() => OnBoarding())
          : Get.to(() => LoginScreen());
    }
  }

  // authentication through email & password
  Future<UserCredential> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //Login - Login the user through the email & password
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //SigIn with Google
  bool _googleInitialized = false;
  Future<UserCredential> signInWithGoogle() async {
    try {
      //instance
      final googleSignIn = GoogleSignIn.instance;

      // initialize only once, and AWAIT it
      if (!_googleInitialized) {
        await googleSignIn.initialize(
          serverClientId:
              '433524117856-ju0d3s7qp6v821a4bg4l4vnjuq64r5m2.apps.googleusercontent.com',
        );
        _googleInitialized = true;
      }

      // optional: make sure you get a fresh account picker
      // await googleSignIn.signOut();

      final GoogleSignInAccount account = await googleSignIn.authenticate();

      final GoogleSignInAuthentication auth = account.authentication;

      final credential = GoogleAuthProvider.credential(idToken: auth.idToken);

      // AWAIT so errors are caught by this try/catch
      return await _auth.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      // user cancelled, config error, etc.
      throw "Google sign-in failed: ${e.code.name}";
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //verify the email - send the verification mail on email
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  ///logout - logut the signUp user
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //delete User account
  Future<void> deleteAccount() async {
    try {
      //this will delete from the fireStore
      await UserRepository.instance.removeUserRecord(currentUser!.uid);

      //this get the publicId to delete the user image from cloudianry
      String publicId = UserController.instance.user.value.publicId;
      //deleting the user from the ucloudinary
      if (publicId.isNotEmpty) {
        UserRepository.instance.deleteProfileImage(publicId);
      }
      //this will delete user from the authentication provider
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }

  //
  Future<void> reauthenticateUserEmailWithPassword(
    String email,
    String password,
  ) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code);
    } on FormatException {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code);
    } catch (e) {
      throw "something went wrong. please try again";
    }
  }
}
