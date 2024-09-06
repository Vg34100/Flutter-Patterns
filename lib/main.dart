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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title goes here'),
      ),
      body: const Column(
        children: [
          Center(
            child: Text('Body goes here'),
          ),
        ],
      ),
    );
  }
}