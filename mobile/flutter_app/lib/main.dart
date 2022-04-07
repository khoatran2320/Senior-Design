///********** Module Packages Import **********///
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

///********** Local Import **********///
import 'firebase_options.dart';
import '/models/lock_model.dart';
import '/models/package_list_model.dart';
import '/utils/authentication_service.dart';
import '/utils/auth_notifications.dart';

///********** UI Import **********///
import "/pages/splash.dart";
import "/utils/colors.dart";

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env"); // DotEnv dotenv = DotEnv() is automatically called during import.
  // await createAndroidNotificationChannel();

  await initializeNotification();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      firebaseMessagingForegroundHandler(message, context);
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => PackageListModel()
        ),
        ChangeNotifierProvider(
          create: (context) => LockModel()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: MaterialColor(
              ColorPallete.cPrimaryAsHex, ColorPallete.materialPrimary),
        ),
        home: const Splash(),
      ),
    );
  }
}
