import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task/screens/requests_screen.dart';
import 'package:task/translation/locale_keys.g.dart';

import '../graphql/App_mutation.dart';
import '../model/CustomerRequest.dart';
import '../utils/my_colors.dart';

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController payeeNameController = TextEditingController();
    TextEditingController typeCodeController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController deliveryTypeCodeController = TextEditingController();
    int requestId = 48;
    int idRequest=48;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.saveRequest.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: payeeNameController,
              decoration: InputDecoration(labelText: LocaleKeys.payeeName.tr()),
            ),
            TextField(
              controller: typeCodeController,
              decoration: InputDecoration(labelText: LocaleKeys.typeCode.tr()),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                  labelText: LocaleKeys.date.tr()),
            ),
            TextField(
              controller: deliveryTypeCodeController,
              decoration:
                   InputDecoration(labelText: LocaleKeys.deliveryTypeCode.tr()),
            ),
            const SizedBox(height: 20),
            Mutation(
              options: MutationOptions(
                document: gql(AppMutation.saveCustomerRequestMutation),
                onCompleted: (dynamic resultData) {
                  if (resultData != null) {
                    if (kDebugMode) {
                      print(
                          "Customer Request Saved with ID: ${resultData['saveCustomerRequest']['id']}");
                    }
                    idRequest= resultData['saveCustomerRequest']['id'];
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Request Saved!")));
                  }
                },
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.red,
                    fixedSize: Size(300.w, 50.h),
                    side: const BorderSide(width: 3.0, color: MyColors.lightRed),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddRequestScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.saveRequest.tr(),
                        style: TextStyle(fontSize: 16.sp, color: Colors.white),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
