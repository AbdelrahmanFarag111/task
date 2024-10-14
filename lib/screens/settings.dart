// ignore: unused_import
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/auth_provider.dart';
import 'package:task/screens/home.dart';
import 'package:task/translation/locale_keys.g.dart';
import 'package:task/utils/my_colors.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController newUserNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.red,
        title: Text(
          LocaleKeys.settings.tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: MyColors.red,
            height: 200.h,
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(bottom: 20.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 60.sp,
                ),
                Text(
                  context.watch<AuthProvider>().username!,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                  ),
                ),
                TextField(
                  controller: newUserNameController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.white),
                    hintText: LocaleKeys.changeUserName,
                    fillColor:  Colors.deepOrangeAccent,
                    filled: true,
                    contentPadding: EdgeInsets.all(8.sp),
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.backgroundColor,
                    fixedSize: Size(300.w, 50.h),
                    side: const BorderSide(width: 3.0, color: MyColors.lightRed),
                  ),
                  onPressed: () {
                    context.read<AuthProvider>().changeUserName(newUserNameController.text);
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      LocaleKeys.changeUserName.tr(),
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
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsetsDirectional.all(12.sp),
                      width: double.infinity,
                      height: 200.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<AuthProvider>().changeLanguage(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Text(
                              LocaleKeys.arabic.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InkWell(
                            onTap: () async{
                              context.read<AuthProvider>().changeLanguage(context);
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            child: Text(
                              LocaleKeys.english.tr(),
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  Icons.language,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  LocaleKeys.language.tr(),
                  style: TextStyle(fontSize: 18.sp),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 25.sp,
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          InkWell(
            onTap: () async {
              await context.read<AuthProvider>().logout();
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 15.w,
                ),
                Icon(
                  Icons.logout_rounded,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  LocaleKeys.logout.tr(),
                  style: TextStyle(fontSize: 18.sp),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 25.sp,
                ),
                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
