import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:webbrains_task/models/user_model.dart' as user;
import 'package:webbrains_task/routes/routes.dart';
import 'package:webbrains_task/utility/utility.dart';

class UserController extends GetxController {
  Future<UserCredential?> register({
    required user.User user,
    required String password,
    required BuildContext context,
    required Function(user.User user) onSuccess,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      if (credential.user != null) {
        if (user.name.trim().isNotEmpty) {
          credential.user!.updateDisplayName(user.name.trim());
        }
      }
      onSuccess(user);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        FlutterToastr.show('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        FlutterToastr.show(
            'The account already exists for that email.', context);
      }
    } catch (e) {
      FlutterToastr.show(e.toString(), context);
    }
    return null;
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        await Utility.setUsers(user.User(
            name: credential.user?.displayName ?? '',
            phoneNo: credential.user?.phoneNumber ?? '',
            email: credential.user?.email ?? ''));
        Get.offAllNamed(Routes.home);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == 'wrong-password') {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == "invalid-credential") {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == "invalid-email") {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      } else if (e.code == "user-disabled") {
        FlutterToastr.show(e.message ?? '', context, duration: 3);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await Utility.clearPref();
    Get.offAllNamed(Routes.login);
  }

  void validator(
    BuildContext context, {
    required String email,
    required String password,
    String? name,
    String? phoneNumber,
    required Function() onSuccess,
  }) {
    if (name != null && name.isEmpty) {
      FlutterToastr.show(
        "Please enter valid name",
        context,
      );
    } else if (email.isEmpty || !Utility.isValidEmail(email)) {
      FlutterToastr.show(
        "Please enter valid email",
        context,
      );
    } else if (phoneNumber != null &&
        (phoneNumber.length < 10 || phoneNumber.length < 10)) {
      FlutterToastr.show(
        "Phone Number must be between 10 to 12 digits",
        context,
      );
    } else if (password.length < 8) {
      FlutterToastr.show(
        "Password must be contain at least 8 characters",
        context,
      );
    } else {
      onSuccess();
    }
  }

  Future<void> authenticateUser(BuildContext context) async {
    user.User? userData = await Utility.getUser();
    Get.offAllNamed((userData != null) ? Routes.home : Routes.login);
  }
}
