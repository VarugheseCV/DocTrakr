// lib/services/document_service.dart

import 'package:flutter/material.dart';
import 'package:doctrakr/models/document.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DocumentService with ChangeNotifier {
  List<Document> _documents = [];

  List<Document> get documents => _documents;

  DocumentService() {
    _loadDocuments();
  }

  Future<void> _loadDocuments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? documentsString = prefs.getString('documents');
    if (documentsString != null) {
      List<dynamic> decoded = json.decode(documentsString);
      _documents = decoded.map((item) => Document.fromMap(item)).toList();
    }
    notifyListeners();
  }

  Future<void> addDocument({
    required String title,
    required String description,
    required DateTime expiryDate,
  }) async {
    Document newDoc = Document(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      expiryDate: expiryDate,
    );
    _documents.add(newDoc);
    await _saveDocuments();
    notifyListeners();
  }

  Future<void> _saveDocuments() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> docs =
        _documents.map((doc) => doc.toMap()).toList();
    await prefs.setString('documents', json.encode(docs));
  }

  Future<List<Document>> getDocuments() async {
    return _documents;
  }

  Future<void> logout() async {
    _documents.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('documents');
    notifyListeners();
  }
}
