import 'package:connectivity_plus/connectivity_plus.dart';
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
}
