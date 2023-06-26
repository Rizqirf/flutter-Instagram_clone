import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/signin_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDe025u8MjbCdWLiRwoHR-L0K-3bEYbmsw",
        appId: "1:532401456944:web:edc6733bcaede2e8c4eaf5",
        messagingSenderId: "532401456944",
        projectId: "instagram-clone-374309",
        storageBucket: "instagram-clone-374309.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      // home: const SigninScreen(),
      // home: const SignupScreen(),
      // home: MobileScreenLayout(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print('masuk');
            if (snapshot.hasData) {
              print('masuk2');
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              print('masuk3');
              return const Center(child: Text('{snapshot.error}'));
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('masuk4');
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          }
          print('masuk5');
          return const SigninScreen();
        },
      ),
    );
  }
}
