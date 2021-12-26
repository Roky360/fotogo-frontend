import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fotogo/widgets/bottom_tab_bar.dart';
import 'package:fotogo/functions/setup_tab_navigator.dart';
import 'package:fotogo/utils/tab_animation_controller.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'pages/pages.dart';

export 'package:fotogo/functions/setup_tab_navigator.dart';

///
class PageNavigator extends HookWidget {
  late ValueNotifier state;
  bool firstBuild = true;

  int pageIndex = 0;

  /* Bottom tab bar variables */
  List<IconData> tabIcons = [
    Icons.home,
    Icons.collections_bookmark_outlined,
    Icons.people_outlined,
    Icons.account_circle_outlined,
  ];
  final List<String> tabTitles = ['Home', 'Albums', 'People', 'Profile'];
  final List<GlobalKey> tabTextKeys = List.generate(4, (_) => GlobalKey());
  Size selectedTabSize = const Size(0, 0);
  Offset selectedTabOffset = const Offset(0, 0);

  late List<AnimationController> inkAnimationControllers;

  Size containerSize = const Size(87, 65);
  double lottieSize = 100;

  /* Pages related variables */
  List<Widget> pages = [
    const HomePage(),
    const AlbumsPage(),
    const PeoplePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    firstBuild ? setupBuild() : null;
    state = useState(0);
    inkAnimationControllers = List.generate(
        4,
        (index) => createTabAnimationController(
              duration: const Duration(milliseconds: 300),
            ));

    return Scaffold(
      appBar: AppBar(
        title: fotogoLogo(),
        centerTitle: true,
      ),
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pages[pageIndex],
      ),
      extendBody: true,
      bottomNavigationBar: bottomTabBar(context),
    );
  }
}
