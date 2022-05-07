import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import 'app_navigator/app_navigator.dart';
import 'on_boarding_setup/sign_in_page.dart';

class AuthChecker extends StatelessWidget {
  final UserProvider _userProvider = UserProvider();

  AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // sign in silently
    if (!_userProvider.isSignedIn) {
      context.read<AuthBloc>().add(const SignInSilentlyEvent());
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state is SignedIn
                    ? const AppNavigator()
                    : PageTransitionSwitcher(
                        transitionBuilder:
                            (child, primaryAnimation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: primaryAnimation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                        reverse: state is SignedOut,
                        child: state is AuthLoading
                            ? Center(
                                child:
                                    AppWidgets.fotogoCircularLoadingAnimation())
                            : state is SignedOut
                                ? SignInPage()
                                : CreateAccountPage(),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}
