import 'package:flutter/material.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/utils/permission_handler.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permissions_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with WidgetsBindingObserver {
  late final PackageInfo packageInfo;
  final UserProvider userProvider = UserProvider();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async => packageInfo = await PackageInfo.fromPlatform());

    WidgetsBinding.instance.addObserver(this);
  }

  // THIS is called whenever life cycle changed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await Permission.storage.isGranted;
      if (granted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  static Widget settingsTile(
      {Widget? leading,
      required Widget title,
      Widget? subtitle,
      Widget? trailing,
      List<Widget>? children}) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      childrenPadding:
          const EdgeInsets.symmetric(horizontal: fPageMargin, vertical: 10),
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      children: children ?? [],
    );
  }

  // Widget permissionsTile() {
  //   final storagePerm = PermissionHandler.requestPermission(Permission.storage);
  //
  //   return FutureBuilder(
  //     future: storagePerm,
  //     builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
  //       if (snapshot.hasData) {
  //         return settingsTile(
  //           leading: const Icon(Icons.perm_media_outlined),
  //           title: const Text('Permissions'),
  //           children: [
  //             ListTile(
  //               leading: const Icon(Icons.folder_outlined),
  //               title: const Text("Storage"),
  //               subtitle: Text(),
  //               trailing: snapshot.data!
  //                   ? const Icon(Icons.done, color: Colors.green)
  //                   : TextButton(
  //                       onPressed: () => openAppSettings(),
  //                       child: const Text("Grant")),
  //             )
  //           ],
  //         );
  //       } else {
  //         return AppWidgets.fotogoCircularLoadingAnimation();
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Delete account
          settingsTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Account'),
            subtitle: Text(
              userProvider.email,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
            children: [
              Center(child: AppWidgets.userCard(context)),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => FotogoDialogs.showDeleteAccountDialog(context),
                style: Theme.of(context).textButtonTheme.style?.copyWith(
                    foregroundColor:
                        MaterialStateProperty.all(Colors.red.shade700),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.red.shade200.withOpacity(.4))),
                child: const Text('Delete account'),
              )
            ],
          ),
          // permissions
          SettingsPermissionsTile(),
          // About
          ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.symmetric(
                horizontal: fPageMargin, vertical: 10),
            leading: const Icon(Icons.info_outlined),
            title: const Text('About'),
            children: [
              FutureBuilder(
                future: PackageInfo.fromPlatform(),
                initialData: PackageInfo(
                    appName: '',
                    buildNumber: '',
                    packageName: '',
                    version: '',
                    buildSignature: ''),
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.hasData
                            ? (snapshot.data as PackageInfo).appName
                            : '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        snapshot.hasData
                            ? "Version ${(snapshot.data as PackageInfo).version}"
                            : '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        snapshot.hasData
                            ? "Build version ${(snapshot.data as PackageInfo).buildNumber}"
                            : '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => FotogoDialogs.showAppDialog(context),
                        child: const Text('More info'),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
