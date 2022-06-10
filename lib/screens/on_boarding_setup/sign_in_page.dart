import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fotogo/auth/bloc/auth_bloc.dart';
import 'package:fotogo/config/constants/theme_constants.dart';
import 'package:fotogo/widgets/app_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class FotogoBasePage extends StatelessWidget {
  final Widget child;
  final Widget bottomSheet;

  const FotogoBasePage(
      {Key? key, required this.child, required this.bottomSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(fPageMargin),
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
      bottomSheet: bottomSheet,
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late bool staySignedIn;

  void changeStaySignedInValue(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('stay_signed_in', value);
  }

  @override
  void initState() {
    super.initState();

    staySignedIn = true;

    changeStaySignedInValue(staySignedIn);
  }

  @override
  Widget build(BuildContext context) {
    return FotogoBasePage(
      bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: StatefulBuilder(
            builder: (context, setState) {
              return ListTile(
                title: Text(
                  "Stay signed in",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: fPageMargin),
                onTap: () => setState(() {
                  staySignedIn = !staySignedIn;
                  changeStaySignedInValue(staySignedIn);
                }),
                trailing: SizedBox(
                  height: 35,
                  width: 70,
                  child: FlutterSwitch(
                    width: 70,
                    height: 35,
                    valueFontSize: 18,
                    toggleSize: 20,
                    value: staySignedIn,
                    borderRadius: 30.0,
                    padding: 8.0,
                    showOnOff: true,
                    activeColor: Theme.of(context).colorScheme.tertiary,
                    onToggle: (val) {
                      setState(() {
                        staySignedIn = val;
                        changeStaySignedInValue(staySignedIn);
                      });
                    },
                  ),
                ),
              );
            },
          )
          // child: Row(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Stay signed in",
          //       style: Theme.of(context).textTheme.subtitle1,
          //     ),
          //     StatefulBuilder(
          //       builder: (context, setState) {
          //         return SizedBox(
          //           height: 35,
          //           child: FlutterSwitch(
          //             width: 70,
          //             height: 35,
          //             valueFontSize: 18,
          //             toggleSize: 20,
          //             value: staySignedIn,
          //             borderRadius: 30.0,
          //             padding: 8.0,
          //             showOnOff: true,
          //             onToggle: (val) {
          //               setState(() {
          //                 staySignedIn = val;
          //                 changeStaySignedInValue(staySignedIn);
          //               });
          //             },
          //           ),
          //         );
          //       },
          //     ),
          //     // TextButton(
          //     //   child: Text('ggs'),
          //     //   onPressed: () => AppWidgets.fotogoSnackBar(context,
          //     //       content: 'dsagfasgasgnasijokgnsaindisaoindsadinodsnio'),
          //     // )
          //   ],
          // ),
          // ),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // title
          Text(
            'Login or sign up',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 50),
          // google button
          SizedBox(
            width: 60.w,
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
                  const SizedBox(width: 12),
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

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FotogoBasePage(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(fPageMargin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'This Google account is not yet registered in fotogo. By clicking '
              'on "Accept and create", a new fotogo account will be created for '
              'you with this Google account profile.\n'
              'You can switch an account by pressing on "Change".',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                TextButton(
                    onPressed: () =>
                        context.read<AuthBloc>().add(const SignOutEvent()),
                    child: const Text('Change')),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async => context
                        .read<AuthBloc>()
                        .add(const CreateAccountEvent()),
                    child: const Text('Accept and create')),
              ],
            ),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Create a new fotogo account',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 40),
          // user card
          AppWidgets.userCard(context),
        ],
      ),
    );
  }
}
