import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:sizer/sizer.dart';

class FotogoBasePage extends StatelessWidget {
  final Widget child;

  const FotogoBasePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(pageMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 7.h),
                SvgPicture.asset(
                  'assets/logos/fotogo_logo_full.svg',
                  height: 45,
                ),
                SizedBox(height: 10.h),
                child
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FotogoBasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  context.read<AuthBloc>().add(const SignInEvent()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/logos/Google__G__Logo.svg',
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text('Sign in with Google'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConfirmAccountPage extends StatelessWidget {
  const ConfirmAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FotogoBasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signed in as',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 0),
          // user card
          AppWidgets.userCard(context),
          const SizedBox(height: 30),
          Text(
            'Stay signed in (implement)',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // const SizedBox(height: 30),
          // const Spacer(),
          Row(
            children: [
              TextButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(const SignOutEvent()),
                  child: const Text('Change')),
              const Spacer(),
              ElevatedButton(
                  onPressed: () => context
                      .read<AuthBloc>()
                      .add(const AccountConfirmedEvent()),
                  child: const Text('Continue')),
            ],
          ),
        ],
      ),
    );
  }
}
