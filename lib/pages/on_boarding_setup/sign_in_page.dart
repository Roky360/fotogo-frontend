import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogo/models/user_bloc/user_bloc.dart';
import 'package:fotogo/pages/app_navigator/app_navigator.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Login or sign up',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 50),
        // google button
        SizedBox(
          width: 60.w,
          height: 45,
          child: OutlinedButton(
            onPressed: () =>
                context.read<UserBloc>().add(const UserSignInEvent()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logos/Google__G__Logo.svg',
                  height: 20,
                ),
                // Image.network(
                //     'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2048px-Google_%22G%22_Logo.svg.png',
                //   width: 20,
                // ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Sign in with Google'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ConfirmAccountPage extends StatelessWidget {
  const ConfirmAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signed in as',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 0),
          // user card
          AppWidgets.userCard(context, context.read<UserBloc>().user!),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () =>
                  context.read<UserBloc>().add(const UserSignOutEvent()),
              child: const Text('Logout')),
          ElevatedButton(
              onPressed: () => context
                  .read<UserBloc>()
                  .add(const UserConfirmedAccountEvent()),
              child: const Text('Continue')),
        ],
      ),
    );
  }
}
