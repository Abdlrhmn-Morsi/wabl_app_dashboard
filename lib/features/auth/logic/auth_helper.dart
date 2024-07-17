import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wabl_app_dashboard/core/helpers/app_local_storage.dart';
import 'package:wabl_app_dashboard/core/helpers/app_saved_key.dart';
import '../../profile/data/models/profile_response_body.dart';

class AuthHelper {
  static String userId() => ApplocalStorage
      .getToken(); // FirebaseAuth.instance.currentUser?.uid ?? "";

  static Future<bool> isExists({
    required String key,
    required String? value,
    required CollectionReference<Map<String, dynamic>> collection,
  }) async {
    bool result = false;
    await collection.where(key, isEqualTo: value).get().then((value) {
      if (value.docs.isNotEmpty) {
        result = true;
      }
    });
    return result;
  }

  static Future<ProfileData> currentUserData({
    required String id,
  }) async {
    var user = ProfileData();
    var usersCol = FirebaseFirestore.instance.collection('users');
    await usersCol.doc(id).get().then(
      (value) {
        if (value.exists) {
          user = ProfileData.fromJson(value.data()!);
        }
      },
    );
    return user;
  }

  static bool isMe(String id) {
    return userId == id;
  }

  static Future<bool> isAuthorized(id) async {
    var user = await currentUserData(id: id);
    await ApplocalStorage.saveString(AppSavedKey.role, user.role ?? "");
    return user.role == 'user' ? false : true;
  }

  static isSuperAdmin() {
    var role = ApplocalStorage.getString(AppSavedKey.role);
    return role == 'super_admin' ? true : false;
  }
}
