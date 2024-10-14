import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql/client.dart';
import 'package:provider/provider.dart';
import 'package:task/firebase_options.dart';
import 'package:task/providers/auth_provider.dart';
import 'package:task/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      path: 'assets/translations',
      // <-- change the path of the translation files
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

final HttpLink _httpLink = HttpLink(
  "<YOUR-BASE-URL>",
  defaultHeaders: {
    'Authorization': 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    'AuthorizationSource': 'API',
  },
);


final ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
  link: _httpLink,
  cache: GraphQLCache(),
));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AuthProvider(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            home: child,
          ),
        );
      },
      child: const HomeScreen(),
    );
  }
}

/// To Generate Locale Translations Keys File
///
/// flutter pub run easy_localization:generate -S assets/translations -O lib/translation -o locale_keys.g.dart -f keys
