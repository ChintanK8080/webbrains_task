import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:webbrains_task/models/user_model.dart' as user;
import 'package:webbrains_task/utility/app_assets.dart';
import 'package:webbrains_task/utility/sqflite_methods.dart';

class Utility {
  static Future<bool> checkInternet() async {
    final result = await Connectivity().checkConnectivity();
    return (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile));
  }

  static setUsers(user.User user) async {
    await (await SqfliteMethods.instance.database)
        .insert(AppAssets.usersTable, user.toJson());
  }

  static Future<user.User?> getUser() async {
    List<Map<String, dynamic>> userData =
        await (await SqfliteMethods.instance.database).query(
      AppAssets.usersTable,
    );
    if (userData.isNotEmpty && userData.first.isNotEmpty) {
      return user.User.fromJson(userData.first);
    }
    return null;
  }

  static clearPref() async {
    await (await SqfliteMethods.instance.database).delete(AppAssets.usersTable);
  }

  static bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static void validator(
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
}
