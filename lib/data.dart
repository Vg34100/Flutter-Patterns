import 'dart:convert';

// The JSON data is defined in the Document class
class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  // Validates that the data is structured correctly without using patterns
  (String, {DateTime modified}) get metadata { // The return type is a record with two fields
    if (_json // The case body only executes if the case pattern matches the data in _json
        case {
          'metadata': {
            'title': String title,
            'modified': String localModified,
          }
        }) {
      return (title, modified: DateTime.parse(localModified)); // The return statement constructs a new record by enclosing the two values in parenthesis
    } else {
      throw const FormatException('Unexpected JSON');
    }
  }

  // RTeturns a list of Block objects, which are used to build the UI
  List<Block> getBlocks() {
    if (_json case {'blocks' : List blocksJson}) {
      return [for (final blockJson in blocksJson) Block.fromJson(blockJson)];
    } else {
      throw const FormatException('Unexpected JSONM format');
    }
  }
}

// Used to read and store the data for one of the blocks in the JSON data
sealed class Block { // sealed - class modifier that means you can only extend or implement this class in the same library
  Block();

  factory Block.fromJson(Map<String, Object?> json) {
    return switch (json) {
      {'type': 'h1', 'text': String text} => HeaderBlock(text),
      {'type': 'p', 'text': String text} => ParagraphBlock(text),
      {'type': 'checkbox', 'text': String text, 'checked': bool checked} =>
        CheckboxBlock(text, checked),
      _ => throw const FormatException('Unexpected JSON format'),
    };
  }
}

// Each of these classes correspond to the different type values from the JSON
class HeaderBlock extends Block {
  final String text;
  HeaderBlock(this.text);
}

class ParagraphBlock extends Block {
  final String text;
  ParagraphBlock(this.text);
}

class CheckboxBlock extends Block {
  final String text;
  final bool isChecked;
  CheckboxBlock(this.text, this.isChecked);
}

// Mocking incoming JSON data with a multi-line string
const documentJson = '''
{
  "metadata": {
    "title": "My Document",
    "modified": "2023-05-10"
  },
  "blocks": [
    {
      "type": "h1",
      "text": "Chapter 1"
    },
    {
      "type": "p",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    },
    {
      "type": "checkbox",
      "checked": true,
      "text": "Learn Dart 3"
    }
  ]
}
''';