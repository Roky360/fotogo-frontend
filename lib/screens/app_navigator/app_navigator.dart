import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/album_creation/bloc/album_creation_bloc.dart';
import 'package:fotogo/album_details/bloc/album_details_bloc.dart';
import 'package:fotogo/screens/app_navigator/app_navigator_data.dart';
import 'package:fotogo/screens/app_navigator_screens.dart';
import 'package:fotogo/screens/create_album/create_album_page.dart';
import 'package:fotogo/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:fotogo/widgets/shared_axis_route.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../single_album/bloc/single_album_bloc.dart';

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
            widget: const HomePage(),
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
            widget: const ProfilePage(),
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
    // curve: Curves.easeOutExpo,
    // curve: Curves.easeOutBack,
  }

  void onRouteChange(int newIndex) {
    if (data.routeIndex != newIndex) {
      setState(() {
        data.routeIndex = newIndex;
      });
    }
  }

  void navigateToCreateAlbumView() {
    Navigator.push(context, sharedAxisRoute(widget: CreateAlbumPage()));
  }

  void openCreateAlbumPanel() async {
    await data.navigationBarController.reverse();
    await data.createAlbumPanelController.show();
    data.createAlbumPanelController.animatePanelToPosition(1,
        duration: const Duration(milliseconds: 700), curve: Curves.easeOutExpo);
  }

  void closeCreateAlbumPanel() async {
    // TODO: panel not closing smoothly. duration and curve have no effect.
    await data.createAlbumPanelController.animatePanelToPosition(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutExpo);
    data.createAlbumPanelController.panelPosition = 0;
    await data.createAlbumPanelController.hide();
  }

  void onPanelClose() async {
    double pos = .03;

    if (data.createAlbumPanelController.isPanelShown &&
        data.createAlbumPanelController.panelPosition <= pos) {
      await data.navigationBarController.forward();
    } else if (data.createAlbumPanelController.isPanelShown &&
        data.createAlbumPanelController.panelPosition > pos) {
      await data.navigationBarController.reverse();
    }
  }

  Widget _getBody() {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> primaryAnimation,
              Animation<double> secondaryAnimation) =>
          FadeThroughTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        child: child,
        // fillColor: Colors.greenAccent,
        fillColor: Theme.of(context).colorScheme.background,
      ),
      child: data.routes[data.routeIndex].widget,
    );

    // return FotogoSlidingUpPanel(
    //   panelController: data.createAlbumPanelController,
    //   panelWidget: CreateAlbumPage(),
    //   onPanelSlideCallback: onPanelClose,
    //   bodyWidget: PageTransitionSwitcher(
    //     duration: const Duration(milliseconds: 500),
    //     transitionBuilder: (Widget child, Animation<double> primaryAnimation,
    //             Animation<double> secondaryAnimation) =>
    //         FadeThroughTransition(
    //       animation: primaryAnimation,
    //       secondaryAnimation: secondaryAnimation,
    //       child: child,
    //       // fillColor: Colors.greenAccent,
    //       fillColor: Theme.of(context).colorScheme.background,
    //     ),
    //     child: data.routes[data.routeIndex].widget,
    //   ),
    // );
  }

  Widget _getBottomNavigationBar() {
    return FotogoBottomNavigationBar(
      data: data,
      controller: _navigationBarAnimation,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onTabTap: onRouteChange,
      onMiddleButtonTap: navigateToCreateAlbumView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumDetailsBloc>(create: (context) => AlbumDetailsBloc()),
        BlocProvider<SingleAlbumBloc>(create: (context) => SingleAlbumBloc()),
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
    super.dispose();

    data.navigationBarController.dispose();
  }
}
