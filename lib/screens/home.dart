import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/screens/sign_in.dart';
import 'package:task/screens/sign_up.dart';
import 'package:task/translation/locale_keys.g.dart';
import 'package:task/utils/my_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
            ),
            Text(
              'قم بتسجيل حسابك للحصول على:',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'عروض وخصومات للشحن',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  width: 10.w,
                ),
                const Icon(
                  Icons.check_circle_outline,
                  color: MyColors.lightRed,
                ),
                SizedBox(
                  width: 25.w,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'تتبع الشحنات والحركات',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  width: 10.w,
                ),
                const Icon(
                  Icons.check_circle_outline,
                  color: MyColors.lightRed,
                ),
                SizedBox(
                  width: 25.w,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'تقرير مالى للشحنات المسلمة',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  width: 10.w,
                ),
                const Icon(
                  Icons.check_circle_outline,
                  color: MyColors.lightRed,
                ),
                SizedBox(
                  width: 25.w,
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.grey,
                fixedSize: Size(300.w, 50.h),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUp()),);
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
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              LocaleKeys.doYouHaveAnAccount.tr(),
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.backgroundColor,
                fixedSize: Size(300.w, 50.h),
                side: const BorderSide(width: 3.0, color: MyColors.lightRed),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn()),);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.login.tr(),
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
