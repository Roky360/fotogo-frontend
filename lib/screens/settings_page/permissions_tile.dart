part of 'settings.dart';

class SettingsPermissionsTile extends StatelessWidget {
  final isStoragePermGranted = PermissionHandler.isGranted(Permission.storage);

  SettingsPermissionsTile({Key? key}) : super(key: key);

  // String getPermissionStatusFormatted(PermissionStatus permission) {
  //   switch (permission) {
  //     case PermissionStatus.granted:
  //     case PermissionStatus.limited:
  //       return "";
  //     case PermissionStatus.denied:
  //       return "Denied";
  //     case PermissionStatus.restricted:
  //       return "Restricted";
  //     case PermissionStatus.permanentlyDenied:
  //       return "Permanently Denied";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isStoragePermGranted,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return _SettingsPageState.settingsTile(
            leading: const Icon(Icons.perm_media_outlined),
            title: const Text('Permissions'),
            children: [
              // storage
              ListTile(
                onTap: snapshot.data! ? null : openAppSettings,
                leading: Icon(Icons.folder_outlined,
                    color: Theme.of(context).colorScheme.tertiary),
                title: Text("Storage",
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary)),
                subtitle: snapshot.data!
                    ? null
                    : Text(
                        "Tap to grant",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Colors.red),
                      ),
                trailing: snapshot.data!
                    ? const Icon(Icons.done, color: Colors.green)
                    : const Icon(Icons.close, color: Colors.red),
              ),
            ],
          );
        } else {
          return AppWidgets.fotogoCircularLoadingAnimation();
        }
      },
    );
  }
}
