import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:postr/Components/KScaffold.dart';
import 'package:postr/Components/Label.dart';
import 'package:postr/Components/kCard.dart';
import 'package:postr/Repository/Auth/auth_repo.dart';
import 'package:postr/Resources/app_config.dart';
import 'package:postr/Resources/colors.dart';
import 'package:postr/Resources/commons.dart';
import 'package:postr/Resources/constants.dart';

class ProfileUI extends ConsumerStatefulWidget {
  const ProfileUI({super.key});

  @override
  ConsumerState<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends ConsumerState<ProfileUI> {
  ValueNotifier isLoading = ValueNotifier(false);
  logout() async {
    try {
      isLoading.value = true;
      final res = await ref.read(authRepo).logout(ref);

      if (!res.error) {
        await AuthRepo.googleSignIn.signOut();
        ref.read(userProvider.notifier).state = null;
        context.go("/login");
      }
    } catch (e) {
      KSnackbar(context, message: "$e", error: true);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return KScaffold(
      isLoading: isLoading,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPadding).copyWith(bottom: 120),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.image),
                  ),
                  width20,
                  Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Label(
                        user.name,
                        fontSize: 25,
                        fontWeight: 500,
                      ).regular,
                      if (user.phone!.isNotEmpty)
                        Label(
                          "+91 ${user.phone}",
                          fontSize: 17,
                          fontWeight: 400,
                        ).subtitle
                      else
                        KCard(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          color: Colors.grey.shade700,
                          child: Row(
                            spacing: 7,
                            children: [
                              const Icon(Icons.edit, size: 15),
                              Label("Add Phone", fontSize: 12).regular
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: KCard(
                      padding: const EdgeInsets.all(20),
                      radius: 100,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.qr_code_scanner_outlined),
                          width20,
                          Flexible(
                            child: Label(
                              "New Track",
                              fontSize: 17,
                              fontWeight: 500,
                            ).regular,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: KCard(
                      padding: const EdgeInsets.all(20),
                      radius: 100,
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.support_agent),
                          width20,
                          Flexible(
                            child: Label(
                              "Contact Us",
                              fontSize: 17,
                              fontWeight: 500,
                            ).regular,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              KCard(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                borderColor: DColor.border,
                color: DColor.scaffold,
                width: double.maxFinite,
                child: Column(
                  spacing: 20,
                  children: [
                    buildSettingTile(
                      onTap: () {
                        context.push("/addresses");
                      },
                      label: "Saved Addresses",
                      icon: Icons.map,
                    ),
                    div,
                    buildSettingTile(
                      onTap: () {},
                      label: "Help",
                      icon: Icons.help,
                    ),
                    div,
                    buildSettingTile(
                      onTap: logout,
                      label: "Log Out",
                      icon: Icons.logout,
                    ),
                  ],
                ),
              ),
              Label("Version $kAppVersion+$kAppBuild").subtitle,
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingTile({
    void Function()? onTap,
    required String label,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 20,
        children: [
          Icon(icon),
          Label(label, fontSize: 17, fontWeight: 400).regular,
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ],
      ),
    );
  }
}
