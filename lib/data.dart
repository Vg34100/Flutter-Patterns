import 'dart:convert';

// The JSON data is defined in the Document class
class Document {
  final Map<String, Object?> _json;
  Document() : _json = jsonDecode(documentJson);

  (String, {DateTime modified}) get metadata { // The return type is a record with two fields
    const title = 'My Document';
    final now = DateTime.now();

    return (title, modified: now); // The return statement constructs a new record by enclosing the two values in parenthesis
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