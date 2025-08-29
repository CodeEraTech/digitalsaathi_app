import 'package:digitalsaathi/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PdfViewer extends StatelessWidget {
  final String url;

  const PdfViewer({super.key, required this.url});

  Future<File> _downloadFile(String url) async {
    var response = await http.get(Uri.parse(url));
    var bytes = response.bodyBytes;
    String dir = (await getTemporaryDirectory()).path;
    File file = File('$dir/${url.split('/').last}');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _downloadFile(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            height:screenHeight(context), // Adjust the height as needed
            child: PDFView(
              filePath: snapshot.data!.path,
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading PDF'));
        }
        return  SizedBox(
          height: screenHeight(context), // Adjust height as needed
          child: Center(child: CircularProgressIndicator(color: Colors.blue,)), // Loading for individual PDFs
        );      },
    );
  }
}
