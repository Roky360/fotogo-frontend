import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_creation/bloc/album_creation_bloc.dart';
import 'package:fotogo/album_details/bloc/album_details_bloc.dart';
import 'package:fotogo/screens/app_navigator/app_navigator_data.dart';
import 'package:fotogo/screens/app_navigator_screens.dart';
import 'package:fotogo/screens/create_album/create_album_page.dart';
import 'package:fotogo/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../single_album/external_bloc/ext_single_album_bloc.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>
    with TickerProviderStateMixin {
  late AppNavigatorData data;

  late Animation _navigationBarAnimation;

  @override
  void initState() {
    super.initState();

    data = AppNavigatorData(
        navigationBarController: AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 400),
          value: 1,
        ),
        createAlbumPanelController: PanelController(),
        routes: [
          NavigatorRoute(
            widget: HomePage(changeAppNavigatorRoute: onRouteChange),
            icon: Icons.image,
            selectedIcon: Icons.image_outlined,
            title: "Gallery",
          ),
          NavigatorRoute(
            widget: const AlbumsPage(),
            icon: Icons.collections_bookmark,
            selectedIcon: Icons.collections_bookmark_outlined,
            title: "Albums",
          ),
          NavigatorRoute(
            widget: const PeoplePage(),
            icon: Icons.people,
            selectedIcon: Icons.people_outlined,
            title: "People",
          ),
          NavigatorRoute(
            widget: ProfilePage(),
            icon: Icons.account_circle,
            selectedIcon: Icons.account_circle_outlined,
            title: "Profile",
          ),
        ]);

    _navigationBarAnimation = CurvedAnimation(
      parent: data.navigationBarController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeOutExpo,
    );
  }

  void onRouteChange(int newIndex) {
    if (data.routeIndex != newIndex) {
      setState(() {
        data.routeIndex = newIndex;
      });
    }
  }

  // void navigateToCreateAlbumView() {
  //   Navigator.push(context, MaterialPageRoute(builder:(context) => CreateAlbumPage()));
  //   // Navigator.push(context, sharedAxisRoute(widget: CreateAlbumPage()));
  // }

  Widget _getBody() {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) =>
          FadeThroughTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        fillColor: Theme.of(context).colorScheme.background,
        child: child,
      ),
      child: data.routes[data.routeIndex].widget,
    );
  }

  Widget _getBottomNavigationBar() {
    return FotogoBottomNavigationBar(
      data: data,
      controller: _navigationBarAnimation,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onTabTap: onRouteChange,
      middleButtonOpensWidget: CreateAlbumPage(),
      // onMiddleButtonTap: navigateToCreateAlbumView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumDetailsBloc>(create: (context) => AlbumDetailsBloc()),
        BlocProvider<ExtSingleAlbumBloc>(
            create: (context) => ExtSingleAlbumBloc()),
        BlocProvider<AlbumCreationBloc>(
            create: (context) => AlbumCreationBloc()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              _getBody(),
              _getBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    data.navigationBarController.dispose();

    super.dispose();
  }
}
