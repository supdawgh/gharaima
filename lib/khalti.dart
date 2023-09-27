import 'package:flutter/material.dart';
import 'package:gm/chat.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: "test_public_key_d5d9f63743584dc38753056b0cc737d5",
      enabledDebugging: true,
      builder: (context, navKey) {
        return MaterialApp(
          title: 'Khalti Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Body(),
          navigatorKey: navKey,
          localizationsDelegates: const [
            KhaltiLocalizations.delegate,
          ],
        );
      },
    );
  }
}
