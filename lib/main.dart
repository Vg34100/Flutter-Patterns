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
    final blocks = document.getBlocks();



    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(title)),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'Last modified $modified}',
            ),          
          ),
          Expanded(child: ListView.builder(
            itemCount: blocks.length,
            itemBuilder: (context, index) {
            return BlockWidget(block: blocks[index]); // constructs a BlockWidget widget for each item in the list of blocks
          }))
        ],
      ),
    );
  }
}

// Determines the styling of each block based on its type field
class BlockWidget extends StatelessWidget {
  final Block block;

  const BlockWidget({
    required this.block,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;
    switch (block.type) {
      case 'h1':
        textStyle = Theme.of(context).textTheme.displayMedium;
      case 'p' || 'checkbox':
        textStyle = Theme.of(context).textTheme.bodyMedium;
        // No need for break now
      case _: // Wildcard pattern - match everything else
        textStyle = Theme.of(context).textTheme.bodySmall;
    }

    return Container(
      margin: const EdgeInsets.all(8),
      child: Text(
        block.text,
        style: textStyle,
      ),
    );
  }
}