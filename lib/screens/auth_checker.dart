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
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              // if (state is UserSignedIn) {
              //   Navigator.pushReplacementNamed(context, '/app_navigator');
              // }
            },
            builder: (BuildContext context, AuthState state) {
              if (state is SignedIn) {
                return const AppNavigator();
              } else if (state is SignedOut || state is ConfirmingAccount || state is AuthLoading) {
                return PageTransitionSwitcher(
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
                            child: AppWidgets.fotogoCircularLoadingAnimation())
                        : state is SignedOut
                            ? const SignInPage()
                            : const ConfirmAccountPage()

                    // state is SignedOut
                    //     ? const SignInPage()
                    //     : const ConfirmAccountPage(),
                    );
              }
              /*else if (state is SignedOut) {
                return const SignInPage();
              } else if (state is ConfirmingAccount) {
                return const ConfirmAccountPage();
              }
              else if (state is AuthLoading) {
                return Center(
                    child: AppWidgets.fotogoCircularLoadingAnimation());
              }*/ else {
                // state is AuthError
                // TODO: move to listener ^
                // TODO: better UI implementations to errors
                return Text(
                  (state as AuthError).message,
                  style: Theme.of(context).textTheme.subtitle1,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
