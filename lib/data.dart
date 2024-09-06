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
class Block {
  final String type;
  final String text;
  Block(this.type, this.text);

  factory Block.fromJson(Map<String, dynamic> json) {
    if (json case {'type': final type, 'text': final text}) {
      return Block(type, text);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }
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
      "checked": false,
      "text": "Learn Dart 3"
    }
  ]
}
''';