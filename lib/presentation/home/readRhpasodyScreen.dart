import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class ReadRhpasodyScreen extends StatelessWidget {
  String pathPDF = "";
  ReadRhpasodyScreen({this.pathPDF});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text("Rhapsody"),
        actions: [],
      ),
      path: pathPDF,
    );
  }
}
