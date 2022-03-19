import 'package:flutter/material.dart';
import 'package:forkify/screens/forkify_list_screen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForkifyListScreen(),
    ),
  );
}
