import 'package:flutter/material.dart';

import 'data.dart';

void main() {
  runApp(const DocumentApp());
}

// DocumentApp sets up the latest version of Material Design for theming the UI
class DocumentApp extends StatelessWidget {
  const DocumentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: DocumentScreen(
        document: Document(),
      ),
    );
  }
}

// DocumentScreen provides the visual layout of the page using the Scaffold widget
class DocumentScreen extends StatelessWidget {
  final Document document;

  const DocumentScreen({
    required this.document,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Light and easy way to return multiple values from a single function call
    // Because they match, the variable declaration pattern destructures the expression
    // - Accessing its values and binding them to new local variables of the same types and names
    // final (title, modified: modified) = document.metadata; - Returns a record
    final (title, :modified) = document.metadata; // Short-hand



    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title)),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Last modified $modified}',  // And this one.
            ),          
          ),
        ],
      ),
    );
  }
}