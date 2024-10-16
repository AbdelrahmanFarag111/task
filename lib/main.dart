import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task/firebase_options.dart';
import 'package:task/providers/auth_provider.dart';
import 'package:task/screens/add_request_screen.dart';
import 'package:task/screens/create_ticket_reply_screen.dart';
import 'package:task/screens/home.dart';
import 'package:task/screens/requests_screen.dart';
import 'package:task/screens/settings.dart';

void main() async {
  // final HttpLink httpLink =
  //     HttpLink("https://accurate.accuratess.com:8001/graphql");
  // final ValueNotifier<GraphQLClient> gClient =
  //     ValueNotifier<GraphQLClient>(GraphQLClient(
  //   link: httpLink,
  //   cache: GraphQLCache(),
  // ));

  Future<ValueNotifier<GraphQLClient>> initializeClient(String token) async {
    // Create an HTTP Link to your GraphQL endpoint
    final HttpLink httpLink = HttpLink(
      'https://accurate.accuratess.com:8001/graphql', // Replace with your API URL
    );

    // Set up AuthLink to include the Authorization header
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $token', // Add your token here
    );

    // Combine the authLink and httpLink
    final Link link = authLink.concat(httpLink);

    // Initialize the GraphQL client
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );

    return client;
  }


  Future<String> getToken() async {
    // This is an example function. Replace it with your logic to get a token.
    return '666|96y7MjWalc8ekpnYhaoDWBckqv73m1NLfdqd31lY8f5c8a3d';
  }
  final token = await getToken(); // Replace with your logic to fetch token
  final gClient = await initializeClient(token);

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
      child:  MyApp(gClient),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp( this.gClient);
  final ValueNotifier<GraphQLClient> gClient;

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
          child: GraphQLProvider(
            client: gClient,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              home: child,
            ),
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
