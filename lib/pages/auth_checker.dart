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
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (BuildContext context, UserState state) {
        if (state is UserSignedOut) {
          return const Login().signInPage(context);
        } else if (state is UserConfirmingAccount) {
          return const Login().confirmAccountPage(context);
        } else if (state is UserLoading) {
          return Center(child: AppWidgets.fotogoCircularLoadingAnimation());
        } else if (state is UserError) {
          // TODO: move to listener ^
          // TODO: better UI implementations to errors
          return Text(
            state.error,
            style: Theme.of(context).textTheme.subtitle1,
          );
        } else {
          // signed in and account confirmed
          return const AppNavigator();
        }
      },
    );
  }
}
