import 'package:emily_cyrus/Utils/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Helper/helper.dart';
import 'HomePage/homePage.dart';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    init();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,

          scaffoldBackgroundColor: emwhite,

          textTheme: TextTheme(
              bodyText2: GoogleFonts.alegreyaSans()
          ),
          appBarTheme: AppBarTheme(
              backgroundColor: emwhite
          )

      ),
      home:  HomePage(),
    );
  }
}
