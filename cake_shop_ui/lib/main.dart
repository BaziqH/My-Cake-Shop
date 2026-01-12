import 'package:cake_shop_ui/home_page.dart';
import 'package:cake_shop_ui/All_Orders_Page.dart';
import 'package:cake_shop_ui/Customised_Order.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}