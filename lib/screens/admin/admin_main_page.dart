import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/admin/admin_service.dart';
import 'package:fotogo/admin/bloc/admin_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/screens/admin/statistics_tab.dart';
import 'package:fotogo/screens/admin/users_tab.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../../config/constants/theme_constants.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  final UserProvider _userProvider = UserProvider();
  final AdminService _adminService = AdminService();
  late final TabController _tabController;
  late final PageController _tabsPageController;

  final Duration _tabAnimationDuration = const Duration(milliseconds: 400);
  final double _tabRadius = 15;

  // late final List<Widget> _tabs;

  Widget getTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(fPageMargin),
      child: Row(
        children: [
          Text(
            "Fotogo Dashboard",
            style: Theme.of(context).textTheme.headline4,
          ),
          const Spacer(),
          InkWell(
            onTap: () => context.read<AuthBloc>().add(const SignOutEvent()),
            borderRadius: BorderRadius.circular(15),
            splashColor: Theme.of(context).colorScheme.onPrimary,
            child: SizedBox(
              height: 60,
              width: 60,
              child: Column(
                children: [
                  Badge(
                    badgeContent: Text(
                      'Admin',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                    alignment: Alignment.topLeft,
                    position: BadgePosition.topStart(start: -20),
                    shape: BadgeShape.square,
                    badgeColor: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(10),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(_userProvider.photoUrl ?? ''),
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _userProvider.displayName!.split(' ').first,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<AdminBloc>().add(const GetStatisticsEvent());
    context.read<AdminBloc>().add(const GetUsersData());

    _tabController = TabController(
      vsync: this,
      length: 2,
      animationDuration: _tabAnimationDuration,
    );
    _tabsPageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is AdminMessage) {
          AppWidgets.fotogoSnackBar(context,
              content: state.message, icon: state.snackBarIcon);
        }
      },
      child: Column(
        children: [
          getTopBar(context),
          // tab bar
          Theme(
            data: ThemeData().copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: TabBar(
              controller: _tabController,
              onTap: (index) => _tabsPageController.animateToPage(index,
                  duration: _tabAnimationDuration, curve: Curves.easeInOutCirc),
              tabs: const [
                Tab(text: "Statistics"),
                Tab(text: "Users"),
              ],
              labelColor: Theme.of(context).colorScheme.onSurface,
              labelStyle: Theme.of(context).textTheme.subtitle1,
              padding: const EdgeInsets.symmetric(horizontal: fPageMargin),
              indicator: RectangularIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
                topLeftRadius: _tabRadius,
                topRightRadius: _tabRadius,
                bottomLeftRadius: _tabRadius,
                bottomRightRadius: _tabRadius,
                horizontalPadding: 12,
              ),
            ),
          ),
          const SizedBox(height: fPageMargin + 10),
          Expanded(
              child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(.7),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (index) => _tabController.animateTo(index),
              children: [StatisticsTab(), UsersTab()],
            ),
          ))
        ],
      ),
    );
  }
}
