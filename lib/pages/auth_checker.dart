import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fotogo/widgets/app_widgets.dart';

import '../models/user_bloc/user_bloc.dart';
import 'app_navigator/app_navigator.dart';
import 'on_boarding_setup/sign_in.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(const UserSignInSilentlyEvent());

    return Scaffold(
      body: SafeArea(
          child: Center(
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserSignedIn) {
                  print('push');
                  Navigator.pushReplacementNamed(context, '/app_navigator');
                }
              },
              builder: (BuildContext context, UserState state) {
                if (state is UserSignedOut) {
                  return const SignInPage();
                } else if (state is UserConfirmingAccount) {
                  return const ConfirmAccountPage();
                } else if (state is UserLoading) {
                  return Center(child: AppWidgets.fotogoCircularLoadingAnimation());
                } else if (state is UserError) {
                  // TODO: move to listener ^
                  // TODO: better UI implementations to errors
                  return Text(
                    state.error,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1,
                  );
                } else {
                  // state is UserSignedIn
                  return AppWidgets.fotogoCircularLoadingAnimation();
                }
              },
            ),
          ),
        ),
    );
  }
}
