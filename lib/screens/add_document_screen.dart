// lib/screens/add_document_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctrakr/services/document_service.dart';
import 'package:intl/intl.dart';

class AddDocumentScreen extends StatefulWidget {
  @override
  State<AddDocumentScreen> createState() => _AddDocumentScreenState();
}

class _AddDocumentScreenState extends State<AddDocumentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _expiryDate = DateTime.now().add(Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    final documentService =
        Provider.of<DocumentService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Document'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Document Title
              TextFormField(
                decoration: InputDecoration(labelText: 'Document Title'),
                onSaved: (value) {
                  _title = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter document title.';
                  }
                  return null;
                },
              ),
              // Description
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description.';
                  }
                  return null;
                },
              ),
              // Expiry Date
              Row(
                children: [
                  Text(
                    'Expiry Date: ${DateFormat.yMd().format(_expiryDate)}',
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: _pickExpiryDate,
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submit(documentService);
                },
                child: Text('Add Document'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickExpiryDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  void _submit(DocumentService documentService) {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      documentService.addDocument(
        title: _title,
        description: _description,
        expiryDate: _expiryDate,
      );
      Navigator.pop(context);
    }
  }
}
