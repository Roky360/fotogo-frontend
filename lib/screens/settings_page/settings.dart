import 'package:flutter/material.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final PackageInfo packageInfo;
  final UserProvider userProvider = UserProvider();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
        (timeStamp) async => packageInfo = await PackageInfo.fromPlatform());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Delete account
          ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.symmetric(
                horizontal: pageMargin, vertical: 10),
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
                child: const Text('Delete account'),
                style: Theme.of(context).textButtonTheme.style?.copyWith(
                    foregroundColor:
                        MaterialStateProperty.all(Colors.red.shade700),
                    backgroundColor: MaterialStateProperty.all(
                        Colors.red.shade200.withOpacity(.4))),
              )
            ],
          ),
          // About
          ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.symmetric(
                horizontal: pageMargin, vertical: 10),
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
                            ? "version ${(snapshot.data as PackageInfo).version}"
                            : '',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.normal),
                      ),
                      Text(
                        snapshot.hasData
                            ? "build version ${(snapshot.data as PackageInfo).buildNumber}"
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
