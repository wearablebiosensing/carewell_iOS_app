import 'package:carewellapp/Chat%20Application/chatViews/feed.dart';
import 'package:carewellapp/Chat%20Application/chatViews/feed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:carewellapp/Chat%20Application/services/auth_services.dart';
import 'package:carewellapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void chatMain() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  _AuthWrapperState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Feed();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
            initialData: null,
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   //primaryColor: Color(0xff145C9E),
          //   primaryColor: Colors.blue[800],
          //   scaffoldBackgroundColor: Colors.blue[100],
          //   primarySwatch: Colors.blue,
          // ),
          home: AuthWrapper(),
        ));
  }
}

class community extends StatelessWidget {
  @override
  Widget build(BuildContext contex) {
    chatMain();
    return Container(
      child: MyApp(),
    );
  }
}
