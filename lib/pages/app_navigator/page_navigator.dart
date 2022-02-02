// import 'dart:async';
//
// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:fotogo/pages/app_navigator/app_navigator_data.dart';
// import 'package:fotogo/widgets/bottom_tab_bar.dart';
// import 'package:fotogo/functions/setup_tab_navigator.dart';
// import 'package:fotogo/utils/tab_animation_controller.dart';
// import 'package:fotogo/widgets/app_widgets.dart';
// import 'package:sizer/sizer.dart';
// import '../../config/constants/constants.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import '../pages.dart';
// import '../../widgets/sliding_up_panel.dart';
// import 'package:fotogo/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';
//
// export 'package:fotogo/functions/setup_tab_navigator.dart';
//
// class PageNavigator extends HookWidget {
//   late ValueNotifier state;
//   bool firstBuild = true;
//
//   int pageIndex = 0;
//
//   /* Bottom tab bar variables */
//   List<IconData> tabIcons = [
//     Icons.home,
//     Icons.collections_bookmark_outlined,
//     Icons.people_outlined,
//     Icons.account_circle_outlined,
//   ];
//   final List<String> tabTitles = ['Home', 'Albums', 'People', 'Profile'];
//   final List<GlobalKey> tabTextKeys = List.generate(4, (_) => GlobalKey());
//   Size selectedTabSize = const Size(0, 0);
//   Offset selectedTabOffset = const Offset(0, 0);
//
//   late List<AnimationController> inkAnimationControllers;
//
//   Size containerSize = const Size(87, 65);
//   double lottieSize = 100;
//
//   /* Pages related variables */
//   List<Widget> pages = [
//     const HomePage(),
//     const AlbumsPage(),
//     const PeoplePage(),
//     const ProfilePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     firstBuild ? setupBuild() : null;
//     state = useState(0);
//     inkAnimationControllers = List.generate(
//         4,
//         (index) => createTabAnimationController(
//               duration: const Duration(milliseconds: 300),
//             ));
//
//     /// For testing the create album panel
//     // Timer(const Duration(milliseconds: 500), () => createAlbumPanelController.open());
//     ///
//     // Timer(const Duration(milliseconds: 300),
//     //     () => createAlbumPanelController.hide());
//
//     // return Container(
//     //   color: Colors.white,
//     //   child: fotogoBottomNavigationBar(),
//     // );
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       // bottomNavigationBar: fotogoBottomNavigationBar(context, AppNavigatorData()),
//     );
//
//     // return getFotogoSlidingUpPanel(
//     //   context,
//     //   panelController: createAlbumPanelController,
//     //   panelWidget: CreateAlbumPage(),
//     //   bodyWidget: Scaffold(
//     //     appBar: AppBar(
//     //       title: fotogoLogo(),
//     //       centerTitle: true,
//     //     ),
//     //     body: PageTransitionSwitcher(
//     //       duration: const Duration(milliseconds: 500),
//     //       transitionBuilder: (child, animation, secondaryAnimation) =>
//     //           FadeThroughTransition(
//     //         animation: animation,
//     //         secondaryAnimation: secondaryAnimation,
//     //         child: child,
//     //       ),
//     //       child: pages[pageIndex],
//     //     ),
//     //     extendBody: true,
//     //     bottomNavigationBar: bottomTabBar(context),
//     //   ),
//     // );
//   }
// }
