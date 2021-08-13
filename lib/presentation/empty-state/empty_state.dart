
import 'package:MyRhapsody/theme/styles.dart';
import 'package:flutter/cupertino.dart';

class EmptyStateScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  final String assetImageUrl;
  final Widget actionButton;

  EmptyStateScreen({this.title, this.subTitle,this.assetImageUrl, this.actionButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5)),
          (assetImageUrl!=null)? Opacity(
            opacity: 0.8,
            child: Container(
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(assetImageUrl),
                    )),

                height: 120),
          ): Container(
              child: Placeholder(
                color: Styles.colorGray.withOpacity(0.5),
              ),
              width: 350,
              height: 220),
          Padding(padding: EdgeInsets.all(20)),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.w500,
                fontSize: 16),
          ),
          Padding(padding: EdgeInsets.all(6)),
          Container(
            width: 450,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Metropolis', color: Styles.colorGray),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(8)),
          (actionButton!=null)?actionButton:Container(),
        ],
      ),
    );
  }
}


/*
actionButton:RaisedButton.icon(
              icon: Icon(
                Icons.edit,
                size: 24,
              ),
              onPressed: () {
                print('action button');
              },
              textColor: Styles.colorWhite,
              color: Styles.colorPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              label: Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 2),
                child: Text(
                  'Write a review',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Metropolis',
                  ),
                ),
              ),
            )
 */