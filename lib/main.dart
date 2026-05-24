import 'package:birthday_website/view/profile_select.dart';
import 'package:birthday_website/view/start_screen.dart';
import 'package:flutter/material.dart';
import 'view/intro.dart';
import 'view/homepage.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/foundation.dart';
import 'utils/web_refresh.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
    setupRefreshRedirect();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // if (kIsWeb) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     if (Uri.base.path != '/') {
    //       Navigator.of(navigatorKey.currentContext!).pushNamedAndRemoveUntil('/', (route) => false);
    //     }
    //   });
    // }
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Birthday App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      initialRoute: '/',
      routes: {'/': (_) => StartScreen(), '/intro': (_) => const IntroPage(), '/home': (_) => const HomePage(), '/profiles': (_) => const ProfileSelectPage()},
    );
  }
}
