import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/auth/user/user_provider.dart';
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
                AppWidgets.fotogoLogoFull(height: 45),
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
  bool staySignedIn = true;

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FotogoBasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // title
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
          const SizedBox(height: 50),
          // stay signed in
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stay signed in",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const Spacer(),
                StatefulBuilder(
                  builder: (context, setState) {
                    return FlutterSwitch(
                      width: 70,
                      height: 35,
                      valueFontSize: 18,
                      toggleSize: 20,
                      value: staySignedIn,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          staySignedIn = val;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FotogoBasePage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create new fotogo account',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          // user card
          AppWidgets.userCard(context),
          const SizedBox(height: 30),
          Text(
            'This Google account is not yet registered in fotogo. By clicking '
            'on "Accept and create", a new fotogo account will be created for '
            'you with this Google account profile.\n'
            'You can switch an account by pressing on "Change".',
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.normal, fontSize: 14),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              TextButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(const SignOutEvent()),
                  child: const Text('Change')),
              const Spacer(),
              ElevatedButton(
                  onPressed: () async =>
                      context.read<AuthBloc>().add(const CreateAccountEvent()),
                  child: const Text('Accept and create')),
            ],
          ),
        ],
      ),
    );
  }
}
