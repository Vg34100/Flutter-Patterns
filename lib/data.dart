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