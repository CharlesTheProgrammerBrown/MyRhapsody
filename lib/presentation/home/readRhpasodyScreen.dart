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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      path: 'https://storage.googleapis.com/myrhapsody.appspot.com/AUTO_DOWNLOADED/August/Arabic.pdf?GoogleAccessId=firebase-adminsdk-bup7x%40myrhapsody.iam.gserviceaccount.com&Expires=16447014000&Signature=N4I%2FsjfouLYtGbt4Dd7NnKEpncahaziv24g8JXEHwH20m8Ws7stPlDuAArwCc1AkqC1D4WDsrAQQWl5hxhHKo6a8NJQkyd2rT5N3yywK%2F1jlIDx5wABUI5jBNnxbczheVuPDci5zWkawInAWLbeNkR5ayFhAYrqOg9YK59B73eI6CUxBks%2BwEEWB%2F2DkiZTWaeGCl82oS66%2FSi4pml8P1HUql91k71clxT7GKQ%2F9jglBbJW3XkdxLu92pMbuNUk%2B3OJeGD64C38MXh6J0GHzel%2BSXcNQg%2BOookV9A7aqiLxM3eN0rJPYImQcNSwc1M6444gr%2BrNqzTYEGel2PMyFaw%3D%3D',
    );
  }
}
