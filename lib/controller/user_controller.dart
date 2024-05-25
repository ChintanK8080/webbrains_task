import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:webbrains_task/models/user_model.dart' as user;
import 'package:webbrains_task/routes/routes.dart';
import 'package:webbrains_task/utility/utility.dart';

class UserController extends GetxController {
  Rx<user.User?> currentUser = Rx(null);
  Rx<List<user.User?>> availableUsers = Rx([]);

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
        currentUser.value = user.User(
          name: credential.user?.displayName ?? '',
          phoneNo: credential.user?.phoneNumber ?? '',
          email: credential.user?.email ?? '',
        );
        await Utility.setUsers(currentUser.value!);
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

  Future<void> authenticateUser(BuildContext context) async {
    user.User? userData = await Utility.getUser();
    Get.offAllNamed((userData != null) ? Routes.home : Routes.login);
  }

  Future<void> storeUserData({
    required user.User user,
    required Function() onSuccess,
  }) async {
    try {
      CollectionReference usersListRef =
          FirebaseFirestore.instance.collection('users');
      log("------" * 20);
      await usersListRef.add(user.toJson());
      await Utility.setUsers(user);
      onSuccess();

      log('User data stored successfully!');
    } catch (e) {
      log('Error storing user data: $e');
    }
  }

  Future<void> getAllUserData() async {
    List<user.User> tempUsersList = [];
    try {
      CollectionReference userDataRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot = await userDataRef.get();

      for (var doc in querySnapshot.docs) {
        final userData = user.User.fromJson(doc.data() as Map<String, dynamic>);
        if (currentUser.value?.email != userData.email) {
          tempUsersList.add(userData);
        } else {
          currentUser.value = userData;
        }
      }
      availableUsers.value = tempUsersList;
      update();
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  Future<void> getCurrentUserData() async {
    final userData = await Utility.getUser();
    if (userData != null) {
      currentUser.value = userData;
      update();
    }
  }
}
