import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/admin/admin_service.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/fotogo_protocol/data_types.dart';
import 'package:fotogo/utils/sizing_utils.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/dialogs.dart';
import 'package:fotogo/widgets/section.dart';

import '../../admin/admin_data_types.dart';
import '../../admin/bloc/admin_bloc.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  final AdminService _adminService = AdminService();

  Widget _baseBadge(BuildContext context,
      {required String content,
      required Color textColor,
      required Color badgeColor}) {
    final textStyle = Theme.of(context)
        .textTheme
        .caption
        ?.copyWith(color: textColor, fontSize: 12);
    return Badge(
      badgeContent: Text(
        content,
        style: textStyle,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      position: BadgePosition.topStart(
          start: -textSize(text: content, style: textStyle!).width / 2 -
              fPageMargin * 2,
          top: -14),
      // start: -textSize(text: content, style: textStyle!).width / 2),
      shape: BadgeShape.square,
      badgeColor: badgeColor,
      borderRadius: BorderRadius.circular(20),
      child: const SizedBox(),
    );
  }

  Widget adminBadge(BuildContext context) => _baseBadge(
        context,
        content: 'Admin',
        textColor: Theme.of(context).colorScheme.error,
        badgeColor: Theme.of(context).colorScheme.errorContainer,
      );

  Widget userBadge(BuildContext context) => _baseBadge(
        context,
        content: 'User',
        textColor: const Color(0xFFD0EEC8),
        badgeColor: const Color(0xFF55D266),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is UserDeleted) setState(() {});
      },
      builder: (context, state) {
        if ((state is UsersFetched || state is StatisticsFetched) &&
            _adminService.usersData != null) {
          final List<UserData> usersData = _adminService.usersData!;
          final TextStyle titleStyle =
              Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14);
          final TextStyle bodyStyle =
              Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14);

          return FotogoSection(
            // padding: EdgeInsets.only(top: 35),
            title: "Users",
            body: Column(
              children: [
                Row(
                  children: [
                    Text("User", style: titleStyle),
                    const Spacer(),
                    Text("User type", style: titleStyle),
                  ],
                ),
                Column(
                    children: usersData
                        .map((e) => ListTile(
                              contentPadding: EdgeInsets.zero,
                              onTap: () =>
                                  FotogoDialogs.showAdminUserDetailsDialog(
                                      context, e,
                                      showDeleteButton:
                                          e.privilegeLevel != UserType.admin),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(e.photoUrl),
                                backgroundColor:
                                    Theme.of(context).colorScheme.shadow,
                              ),
                              title: Text(
                                e.displayName,
                                style: bodyStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              subtitle: Text(e.email, style: bodyStyle),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  e.privilegeLevel == UserType.admin
                                      ? adminBadge(context)
                                      : userBadge(context),
                                ],
                              ),
                            ))
                        .toList()),
              ],
            ),
          );
        } else {
          // loading
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppWidgets.fotogoCircularLoadingAnimation(),
              const SizedBox(height: 20),
              Text(
                "Getting users data...",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          );
        }
      },
    );
  }
}
