import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/pages/create_album/create_album_page.dart';
import 'package:fotogo/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:fotogo/widgets/sliding_up_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

    data = AppNavigatorData();

    data.navigationBarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 400),
      value: 1,
    );

    _navigationBarAnimation = CurvedAnimation(
      parent: data.navigationBarController,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeOutExpo,
    );
    // curve: Curves.easeOutExpo,
    // curve: Curves.easeOutBack,

    data.createAlbumPanelController = PanelController();
  }

  void onRouteChange(int newIndex) {
    setState(() {
      data.routeIndex = newIndex;
    });
  }

  void openCreateAlbumPanel() async {
    await data.navigationBarController.reverse();
    await data.createAlbumPanelController.show();
    data.createAlbumPanelController.animatePanelToPosition(1,
        duration: const Duration(milliseconds: 700), curve: Curves.easeOutExpo);
  }

  void closeCreateAlbumPanel() async {
    // TODO: panel not closing smoothly. duration and curve have no effect.
    data.createAlbumPanelController.animatePanelToPosition(0,
        duration: const Duration(milliseconds: 5000),
        curve: Curves.easeOutExpo);
    await data.createAlbumPanelController.hide();
  }

  void onPanelClose() {
    double pos = .03;

    if (data.createAlbumPanelController.isPanelShown &&
        data.createAlbumPanelController.panelPosition <= pos) {
      data.navigationBarController.forward();
    } else if (data.createAlbumPanelController.isPanelShown &&
        data.createAlbumPanelController.panelPosition > pos) {
      data.navigationBarController.reverse();
    }
  }

  Widget _getBody() {
    return FotogoSlidingUpPanel(
      panelController: data.createAlbumPanelController,
      panelWidget: CreateAlbumPage(
        closePanelCallback: closeCreateAlbumPanel,
      ),
      onPanelSlideCallback: onPanelClose,
      bodyWidget: PageTransitionSwitcher(
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
      ),
    );
  }

  Widget _getBottomNavigationBar() {
    return FotogoBottomNavigationBar(
      data: data,
      controller: _navigationBarAnimation,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      onTabTap: onRouteChange,
      onMiddleButtonTap: openCreateAlbumPanel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _getBody(),
            _getBottomNavigationBar(),
          ],
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
