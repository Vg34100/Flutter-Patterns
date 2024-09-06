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
    final formattedModifiedDate = formatDate(modified);
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
              'Last modified $formattedModifiedDate',
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
    return Container(
      margin: const EdgeInsets.all(8),
      child: switch (block) { // Turned a switch statement to a switch expression
        HeaderBlock(:final text) => Text(
            text,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ParagraphBlock(:final text) => Text(text),
        CheckboxBlock(:final text, :final isChecked) => Row(
            children: [
              Checkbox(value: isChecked, onChanged: (_) {}),
              Text(text),
            ],
          ),
      },
    );
  }
}

// Improve how the last modified date is displayed using patterns

// Returns a switch expression that switches on the value difference (span of time between today and modified)
String formatDate(DateTime dateTime) {
  final today = DateTime.now();
  final difference = dateTime.difference(today);

  // Exhaustive switch: every case is handled
  return switch (difference) {
    Duration(inDays: 0) => 'today',
    Duration(inDays: 1) => 'tomorrow',
    Duration(inDays: -1) => 'yesterday',
    // A guard clause (when) only add a condition to a pattearn after it's matched
    Duration(inDays: final days) when days > 7 => '${days ~/ 7} weeks from now',
    Duration(inDays: final days) when days < -7 =>
      '${days.abs() ~/ 7} weeks ago',                                            
    Duration(inDays: final days, isNegative: true) => '${days.abs()} days ago',
    Duration(inDays: final days) => '$days days from now',
  };
}

