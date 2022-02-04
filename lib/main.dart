import 'dart:async';

import 'package:flutter/material.dart';
import 'package:organizer/constants/route.dart';
import 'package:organizer/providers/shared_state.dart';
import 'package:organizer/screens/amounts_screen.dart';
import 'package:organizer/screens/categories_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SharedState>.value(value: SharedState())
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const CategoriesScreen(),
          AMOUNTS_ROUTE: (context) => const Amounts()
        },
      ),
    );
  }
}
