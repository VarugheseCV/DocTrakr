// lib/widgets/document_tile.dart

import 'package:flutter/material.dart';
import 'package:doctrakr/models/document.dart';
import 'package:intl/intl.dart';

class DocumentTile extends StatelessWidget {
  final Document document;

  DocumentTile({required this.document});

  @override
  Widget build(BuildContext context) {
    final daysLeft = document.expiryDate.difference(DateTime.now()).inDays;

    return ListTile(
      title: Text(document.title),
      subtitle:
          Text('Expires on ${DateFormat.yMd().format(document.expiryDate)}'),
      trailing: daysLeft >= 0
          ? Text('$daysLeft days left')
          : Text(
              'Expired',
              style: TextStyle(color: Colors.red),
            ),
      onTap: () {
        // Navigate to Document Detail Screen if implemented
      },
    );
  }
}
