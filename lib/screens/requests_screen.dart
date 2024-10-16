import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:task/graphql/app_query.dart';
import 'package:task/translation/locale_keys.g.dart';
import 'package:task/utils/my_colors.dart';

class RequestsScreen extends StatelessWidget {
  RequestsScreen({super.key, required this.id});

  int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(LocaleKeys.requestScreen.tr()),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(AppQuery.customerRequestQuery),
          variables: {
            'id': id,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Center(
              child: Text('Error: ${result.exception.toString()}'),
            );
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result.data == null || result.data!['customerRequest'] == null) {
            return const Center(
              child: Text('No customer request found for ID ${53}'),
            );
          }

          final customerRequest = result.data!['customerRequest'];

          return Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LocaleKeys.request.tr(),
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Text(
                      ': ${customerRequest['id']}',
                      style: const TextStyle(fontSize: 24, color: Colors.red),
                    ),
                  ],
                ),
                Container(
                  width: 280.w,
                  height: 200.h,
                  margin: EdgeInsetsDirectional.all(22.sp),
                  padding: EdgeInsetsDirectional.all(22.sp),
                  color: MyColors.grey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${LocaleKeys.payeeName.tr()} : \n ${customerRequest['payeeName']}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${LocaleKeys.notes} \n ${customerRequest['notes'] ?? "No notes"}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${LocaleKeys.date.tr()}:\n ${customerRequest['date']}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${LocaleKeys.paymentAccountNumber}:\n ${customerRequest['paymentAccountNumber']}',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
