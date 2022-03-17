///********** Module Packages Import **********///
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

import '/utils/authentication_service.dart';

///********** UI Import **********///
import "/pages/splash.dart";
import "/utils/colors.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(
            ColorPallete.cPrimaryAsHex, ColorPallete.materialPrimary),
      ),
      home: const Splash(),
    );
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: resolve this
    final firebaseUser = ref.watch(firebaseAuthProvider).userChanges();
    // final firebaseUser = null;

    if (firebaseUser != null) {
      return Text('Logged In');
    }
    return Text('Sign In!');
  }
}
