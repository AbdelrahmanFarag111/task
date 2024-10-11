import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/auth_provider.dart';
import 'package:task/screens/settings.dart';
import 'package:task/screens/sign_in.dart';
import 'package:task/translation/locale_keys.g.dart';
import 'package:task/utils/my_colors.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
              LocaleKeys.register,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.white),
            ),
            SizedBox(
              height: 80.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: LocaleKeys.email,
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
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: LocaleKeys.password,
                    suffixIcon: const Icon(Icons.key),
                    prefixIcon:const Icon( Icons.visibility_off,),
                    suffixIconColor: Colors.white,
                    fillColor: MyColors.grey,
                    filled: true,
                    contentPadding: EdgeInsets.all(8.sp),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.grey,
                fixedSize: Size(300.w, 50.h),
              ),
              onPressed: () async {
                await context.read<AuthProvider>().register(
                    email: emailController.text,
                    password: passwordController.text);
                FocusManager.instance.primaryFocus?.unfocus();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.register,
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
            SizedBox(
              height: 40.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.lightRed,
                fixedSize: Size(300.w, 50.h),
                side: const BorderSide(width: 3.0, color: MyColors.lightRed),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.login,
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  const Icon(
                    Icons.lock,
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
}
