// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctrakr/services/document_service.dart';
import 'package:doctrakr/models/document.dart';
import 'package:doctrakr/screens/add_document_screen.dart';
import 'package:doctrakr/widgets/document_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final documentService = Provider.of<DocumentService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Documents'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              documentService.logout();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Document>>(
        future: documentService.getDocuments(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading documents'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No documents found.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Document doc = snapshot.data![index];
              return DocumentTile(document: doc);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDocumentScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Document',
      ),
    );
  }
}
