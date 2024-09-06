import 'dart:convert';

// The JSON data is defined in the Document class
class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);
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