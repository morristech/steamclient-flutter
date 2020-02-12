import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:steamclient/desktop/desktop_app.dart';
import 'package:steamclient/services/navigation_service.dart';
import 'package:provider/provider.dart';
import 'package:steamclient/common/predefined_colors.dart' as PredefinedColors;

import 'package:steamclient/common/static_data.dart' as routes;
import 'package:steamclient/router.dart' as router;
import 'package:steamclient/vms/auth_vm.dart';

import './locator.dart';

Future main() async {
  await DotEnv().load('.env');

  setupLocator();
  runApp(Platform.isMacOS ? DesktopApp() : SteamClientApp());
}

class SteamClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Steam',
        theme: ThemeData(
            primaryColor: PredefinedColors.ALMOST_BLACK,
            primarySwatch: Colors.grey,
            backgroundColor: Colors.grey[800]),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: router.generateRoute,
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (context) => Text('Nothing')),
        initialRoute: routes.SteamTablayout,
      ),
    );
  }
}
