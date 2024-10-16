import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task/graphql/App_mutation.dart';
import 'package:task/translation/locale_keys.g.dart';
import 'package:task/utils/my_colors.dart';

class CreateTicketReplyScreen extends StatelessWidget {
  const CreateTicketReplyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController bodyController = TextEditingController();
    TextEditingController idController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.createTicketReply.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: "id"),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(labelText: "Reply Body"),
            ),
            SizedBox(height: 20.h),
            Mutation(
              options: MutationOptions(
                document: gql(AppMutation.createTicketReplyMutation),
                onCompleted: (dynamic resultData) {
                  if (resultData != null) {
                    if (kDebugMode) {
                      print(
                          "Reply Created with ID: ${resultData['createTicketReply']['id']}");
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Reply Created!")));
                  }
                },
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    fixedSize: Size(300.w, 50.h),
                    side:
                        const BorderSide(width: 3.0, color: MyColors.lightRed),
                  ),
                  onPressed: () {
                    runMutation({
                      'body': bodyController.text,
                      'ticketId': 1, // Replace with dynamic ticket ID if needed
                    });
                    if (result?.hasException ?? false) {
                      Text(result!.exception.toString());
                    }
                  },
                  child: Text(
                    LocaleKeys.submitReply.tr(),
                    style: TextStyle(color: Colors.white),
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
