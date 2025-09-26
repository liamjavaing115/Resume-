import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart'; // ✅ correct


void main() {
  runApp(
    const MaterialApp(
      home: Expenses()
    ),
  );
}

