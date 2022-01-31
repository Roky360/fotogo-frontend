import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
import 'package:fotogo/widgets/bottom_navigation_bar/animation_controller.dart';
import 'package:fotogo/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:sizer/sizer.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>
    with TickerProviderStateMixin {
  late AppNavigatorData appNavigatorData;

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    appNavigatorData = AppNavigatorData();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: 1,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeOutExpo,
    );
    // curve: Curves.easeOutExpo,
    // curve: Curves.easeOutBack,

    // _animation = Tween(
    //   begin: 10,
    //   end: -60,
    // ).animate(_controller);
  }

  Widget getBody() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _controller.forward();
          },
          child: Text('show'),
        ),
        ElevatedButton(
          onPressed: () {
            _controller.reverse();
          },
          child: Text('hide'),
        ),
        ElevatedButton(
          onPressed: () {
            print(_controller.value);
          },
          child: Text('val'),
        ),
        Align(
          heightFactor: 2,
          alignment: Alignment.bottomCenter,
          child: Image.network(
              'https://colors.dopely.top/inside-colors/wp-content/uploads/2021/06/spiritual-colors.jpg'),
          // child: Image.asset('assets/test_images/amsterdam.png'),
        ),
      ],
    );
  }

  void onRouteChange(int newIndex) {
    setState(() {
      appNavigatorData.routeIndex = newIndex;
    });
  }

  void openCreateAlbumPanel() {}

  Widget getBottomNavigationBar() {
    return FotogoBottomNavigationBar(
      data: appNavigatorData,
      controller: _animation,
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
            getBody(),
            getBottomNavigationBar(),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      // bottomNavigationBar: getBottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
