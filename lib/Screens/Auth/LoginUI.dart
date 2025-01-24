import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kButton.dart';
import 'package:postr/Models/User_Model.dart';
import 'package:postr/Repository/Auth/auth_repo.dart';
import 'package:postr/Resources/constants.dart';
import 'package:postr/Resources/theme.dart';

import '../../Resources/colors.dart';
import '../../Resources/commons.dart';

class LoginUI extends ConsumerStatefulWidget {
  const LoginUI({super.key});

  @override
  ConsumerState<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends ConsumerState<LoginUI> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  _signInWithGoogle() async {
    try {
      isLoading.value = true;
      final res = await ref.read(authRepo).signInWithGoogle(ref);

      if (!res.error) {
        ref.read(userProvider.notifier).state = UserModel.fromMap(res.data);
        context.go("/");
      } else {
        KSnackbar(context, message: res.message, error: res.error);
      }
    } catch (e) {
      KSnackbar(context, message: "$e", error: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      isLoading: isLoading,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.rotate(
                              angle: .2,
                              child: const Icon(
                                Icons.adb_rounded,
                                color: DColor.primary,
                                size: 40,
                              ),
                            ),
                            width10,
                            Label(
                              "Postr",
                              fontSize: 40,
                              fontStyle: FontStyle.italic,
                              fontWeight: 800,
                            ).title,
                          ],
                        ),
                        height20,
                        Label(
                          "Fastest and most trusted package delivery",
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ).subtitle,
                      ],
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.security,
                        size: 16,
                        color: kColor(context).primaryContainer,
                      ),
                      Expanded(
                        child: Label(
                          "Your data is secured",
                          fontWeight: 400,
                          color: kColor(context).primaryContainer,
                        ).regular,
                      )
                    ],
                  ),
                  KButton(
                    onPressed: _signInWithGoogle,
                    label: "Google",
                    backgroundColor: DColor.card,
                    foregroundColor: Colors.white,
                    icon: Image.asset(
                      "$kImagePath/google-logo.png",
                      height: 20,
                    ),
                    fontSize: 20,
                    padding: const EdgeInsets.all(20),
                    style: KButtonStyle.outlined,
                    borderColor: DColor.border,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
