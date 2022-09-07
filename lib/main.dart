import 'package:downloaddemo/screens/download_screen.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
      backgroundColor: Colors.black,
      radius: 5.0,
      textPadding: const EdgeInsets.all(10.0),
      animationCurve: Curves.easeIn,
      // ignore: deprecated_member_use
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const DownloadScreen(),
      ),
    );
  }
}

