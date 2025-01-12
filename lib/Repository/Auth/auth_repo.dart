import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:postr/Helper/api_config.dart';
import 'package:postr/Models/User_Model.dart';
import 'package:postr/Models/Response_Model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final userProvider = StateProvider<UserModel?>(
  (ref) => null,
);

final authRepo = Provider(
  (ref) => AuthRepo(),
);

final authFuture = FutureProvider(
  (ref) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();

    final res =
        await apiCallBack(path: "/user/auth", body: {"fcmToken": fcmToken});

    if (!res.error) {
      ref.read(userProvider.notifier).state = UserModel.fromMap(res.data);
    }
  },
);

class AuthRepo {
  static Future<ResponseModel> sendTokenToBackend(String idToken) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();

      final res = await apiCallBack(
        path: "/user/login-with-google",
        body: {"token": idToken, "fcmToken": fcmToken},
      );

      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId:
            "526890697325-rtmpch385f38js8aq1ip8c66t8iibfuh.apps.googleusercontent.com",
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
          'https://www.googleapis.com/auth/userinfo.profile',
          'openid',
        ],
      );
      await googleSignIn.signOut();

      final GoogleSignInAccount? gAccount = await googleSignIn.signIn();

      if (gAccount != null) {
        final GoogleSignInAuthentication gAuth = await gAccount.authentication;

        // log("Acccess Token : ${googleSignInAuthentication.accessToken}");
        // log("idToken : ${googleSignInAuthentication.idToken}");

        return await sendTokenToBackend(gAuth.idToken ?? "");
      }
      return ResponseModel(error: true, message: "User is null!");
    } catch (error) {
      rethrow;
    }
  }
}
