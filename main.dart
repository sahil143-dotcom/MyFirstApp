import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'core/services/personalization_service.dart';
import 'data/providers/event_provider.dart';
import 'data/providers/user_provider.dart';
import 'presentation/screens/onboarding/personalization_onboarding.dart';
import 'presentation/screens/home/home_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // await Firebase.initializeApp();
  // FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  
  // Initialize notifications
  await NotificationService.initialize(flutterLocalNotificationsPlugin);
  
  // Initialize personalization service
  await PersonalizationService.initialize();
  
  runApp(const AllCollegeEventApp());
}

class AllCollegeEventApp extends StatelessWidget {
  const AllCollegeEventApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
        title: 'AllCollegeEvent',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
