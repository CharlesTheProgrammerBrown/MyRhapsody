import 'dart:async';

import 'package:MyRhapsody/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:rive/rive.dart';

/*
class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key key, @required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Url'),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
*/

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key key, @required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorSecondaryLight,
      appBar: AppBar(
        backgroundColor: Styles.colorSecondary,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: Icon(CupertinoIcons.share),
              onPressed: () {
                showDialog(
                  barrierColor: Styles.colorSecondary.withOpacity(0.4),
                    context: context,

                    builder: (BuildContext context) {
                      return new AlertDialog(
                        backgroundColor: Styles.colorSecondaryLight,
                        content: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.7,
                              child: ListView(
                                children: [
                                  Text('Distribution', style: Styles.textRegularMedium,),
                            Padding(padding: EdgeInsets.all(4)),
                                  Text('Select contacts to distribute Rhapsody to'),
                                  Padding(padding: EdgeInsets.all(8)),
                                  CheckboxListTile(
                                      value: false, onChanged: (bool) {},
                                  title: Text('Charles Brown Tinashe'),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Charles.t.brown@gmail.com'),
                                      Text('English'),
                                    ],
                                  ),),
                                  Padding(padding: EdgeInsets.all(2)),
                                   CheckboxListTile(
                                      value: false, onChanged: (bool) {},
                                  title: Text('Johonny deep'),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('jhdeep@gmail.com'),
                                      Text('English'),
                                    ],
                                  ),),
                                  Padding(padding: EdgeInsets.all(2)),
                                   CheckboxListTile(
                                      value: false, onChanged: (bool) {},
                                  title: Text('John Tinashe'),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('John.brown@gmail.com'),
                                      Text('French'),
                                    ],
                                  ),),
                                  Padding(padding: EdgeInsets.all(2)),
                                  CheckboxListTile(
                                    value: false,
                                    onChanged: (bool) {},
                                    title: Text('Micheal Tango'),
                                    subtitle: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Charles.t.brown@gmail.com'),
                                        Text('Agui'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                bottom:10,
                                right:10,
                                child: FloatingActionButton(
                                 backgroundColor: Styles.colorPrimary,
                                    tooltip:'Distribute',onPressed: (){}, child: Icon(Icons.check)))
                          ],
                        ),
                      );
                    });
              },
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Center(
        child: //const PDF().cachedFromUrl(
          PDF().fromUrl(
          url,
          placeholder: (double progress) => Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: RiveAnimation.asset(
                  'assets/rive/document_animation.riv',
                  placeHolder: Center(
                      child: CircularProgressIndicator(
                    value: progress / 100,
                  )),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.45,
                bottom: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logos/MyRhapsody.png",
                      fit: BoxFit.scaleDown,
                      height: 40,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.452,
                bottom: MediaQuery.of(context).size.height * 0.203,
                child: Center(
                    child: CircularProgressIndicator(
                  value: progress / 100,
                )),
              ),
            ],
          ), //
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}

/*
class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key key, @required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Asset'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900],
                      ),
                      child: Text(snapshot.data),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int current, int total) =>
            _pageCountController.add('${current + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage();
          final int pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        await pdfController.getCurrentPage() - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        await pdfController.getCurrentPage() + 1;
                    final int numberOfPages =
                    await pdfController.getPageCount();
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
*/
