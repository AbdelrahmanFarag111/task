import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task/graphql/App_mutation.dart';
import 'package:task/providers/auth_provider.dart';
import 'package:task/screens/add_request_screen.dart';
import 'package:task/screens/settings.dart';
import 'package:task/screens/sign_up.dart';
import 'package:task/translation/locale_keys.g.dart';
import 'package:task/utils/my_colors.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(backgroundColor: Colors.transparent, actions: [
        Text(
          'Accurate',
          style: TextStyle(
            fontSize: 16.sp,
            color: MyColors.lightRed,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80.h,
            ),
            Text(
              LocaleKeys.login.tr(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white),
            ),
            SizedBox(
              height: 80.h,
            ),
            Center(
              child: SizedBox(
                width: 280.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: LocaleKeys.email.tr(),
                        fillColor: MyColors.grey,
                        suffixIcon: const Icon(Icons.person),
                        suffixIconColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(8.sp),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: !context.watch<AuthProvider>().hidePassword,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: LocaleKeys.password.tr(),
                        suffixIcon: InkWell(
                          onTap: () {
                            context.read<AuthProvider>().protectText();
                          },
                          child: Icon(context.watch<AuthProvider>().hidePassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        suffixIconColor: Colors.white,
                        fillColor: MyColors.grey,
                        filled: true,
                        contentPadding: EdgeInsets.all(8.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Mutation(
              options: MutationOptions(
                document: gql(AppMutation.login),
                onCompleted: (dynamic resultData) {
                  if (kDebugMode) {
                    print(resultData);
                  }
                  if (resultData != null) {
                    final user = resultData['login']['user'];
                    final token = resultData['login']['token'];
                    if (kDebugMode) {
                      print('Logged in user: ${user['username']}');
                    }
                    if (kDebugMode) {
                      print('Token: $token');
                    }
                  }
                },
                onError: (e) {
                  _showSnackBar(context, e.toString(), false);
                  if (kDebugMode) {
                    print(e);
                  }
                },
              ),
              builder: (
                RunMutation? runMutation,
                QueryResult? result,
              ) {
                return TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: MyColors.grey,
                    fixedSize: Size(250.w, 50.h),
                  ),
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        emailController.text.isEmpty) {
                      _showSnackBar(context, "Fill the fields", false);
                    } else {
                      context.read<AuthProvider>().changeUserName(emailController.text);
                      runMutation!({
                        'username': emailController.text,
                        'password': passwordController.text,
                        'fcmToken': '',
                        'rememberMe': false,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()),
                      );
                    }
                  },
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(
                    LocaleKeys.login.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.grey,
                fixedSize: Size(250.w, 50.h),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.register.tr(),
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  const Icon(
                    Icons.add_circle_outline_sharp,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String theMessage, bool succsess) {
    final snackBar = SnackBar(
        content: ListTile(
            title: Text(theMessage),
            leading: succsess
                ? const Icon(Icons.check, color: Colors.green)
                : const Icon(Icons.close, color: Colors.red)),
        backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
