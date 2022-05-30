import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/screens/admin/admin_main_page.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:fotogo/widgets/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_navigator/app_navigator.dart';
import 'on_boarding_setup/sign_in_page.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  final UserProvider _userProvider = UserProvider();

  Future<bool> _getStaySignedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('stay_signed_in') ?? false;
  }

  void _setStaySignedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('stay_signed_in', value);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (await _getStaySignedIn() && !_userProvider.isSignedIn) {
        context.read<AuthBloc>().add(const SignInSilentlyEvent());
      } else {
        context.read<AuthBloc>().add(const SignOutEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthMessage) {
                AppWidgets.fotogoSnackBar(
                  context,
                  content: state.message,
                  icon: state.icon,
                );
              } else if (state is AdminSignedIn) {
                // For security purposes, if admin has signed - set
                // stay_signed_in to false.
                _setStaySignedIn(false);
              }
            },
            builder: (BuildContext context, AuthState state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state is AdminSignedIn
                    ? const AdminPage()
                    : state is UserSignedIn
                        ? const AppNavigator()
                        : PageTransitionSwitcher(
                            transitionBuilder:
                                (child, primaryAnimation, secondaryAnimation) {
                              return SharedAxisTransition(
                                animation: primaryAnimation,
                                secondaryAnimation: secondaryAnimation,
                                transitionType:
                                    SharedAxisTransitionType.horizontal,
                                child: child,
                              );
                            },
                            reverse: state is SignedOut,
                            child: state is AuthLoading
                                ? FotogoSplashScreen(
                                    message: state.loadingMessage,
                                    showLoadingAnimation:
                                        state.showLoadingAnimation,
                                  )
                                : state is SignedOut
                                    ? const SignInPage()
                                    : const CreateAccountPage(),
                          ),
              );
            },
          ),
        ),
      ),
    );
  }
}
