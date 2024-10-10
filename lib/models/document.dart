// lib/models/document.dart

import 'dart:convert';

class Document {
  String id;
  String title;
  String description;
  DateTime expiryDate;

  Document({
    required this.id,
    required this.title,
    required this.description,
    required this.expiryDate,
  });

  // Convert a Document into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  // Convert a Map into a Document.
  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      expiryDate: DateTime.parse(map['expiryDate']),
    );
  }

  // Encode to JSON.
  String toJson() => json.encode(toMap());

  // Decode from JSON.
  factory Document.fromJson(String source) =>
      Document.fromMap(json.decode(source));
}
