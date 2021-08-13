import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/presentation/empty-state/empty_state.dart';
import 'package:MyRhapsody/presentation/home/pdfReader.dart';
import 'package:MyRhapsody/repositories/blocs/authenticationBloc/authentication_bloc.dart';
import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyEntity.dart';
import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyModel.dart';
import 'package:MyRhapsody/services/authService.dart';
import 'package:MyRhapsody/theme/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_fade/image_fade.dart';
import 'readRhpasodyScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:io';
import 'package:rive/rive.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton<String>(
            icon: Row(
              children: [
                Text('English', style: TextStyle(color: Colors.white)),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                )
              ],
            ),
            items: <String>['English', 'French', 'Arabic', 'Hausa']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: new Text(
                  value,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (_) {},
          ),
          FlatButton(
            onPressed: () {
              showDialog(
                  barrierColor: Styles.colorPrimary.withOpacity(0.9),
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      backgroundColor: Styles.colorSecondaryLight,
                      title: new Text("Settings"),
                      content: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            Text(
                                'This app was created by KingsTech Team during qubators Hackathon with Love 💗'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () {}, child: Text('Logout')),
                                TextButton(
                                    onPressed: () {
                                      showAboutDialog(
                                          context: context,
                                          applicationVersion: '0.0.1',
                                          applicationName: 'MyRhapsody App',
                                          applicationIcon: Image.asset(
                                            "assets/logos/MyRhapsody.png",
                                            fit: BoxFit.scaleDown,
                                            height: 40,
                                          ),
                                          applicationLegalese:
                                              'MyRhapsody is a property of Kings Tech,'
                                              'made during the qubators Hackathon. Thank you');
                                    },
                                    child: Text('About Us'))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
        title: Row(
          children: [
            Image.asset(
              "assets/logos/MyRhapsody.png",
              fit: BoxFit.scaleDown,
              height: 40,
            ),
            Text("MyRhapsody"),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        backgroundColor: Styles.colorSecondary,
        elevation: 0.0,
      ),
      backgroundColor: Styles.colorSecondaryLight,
      body: SingleChildScrollView(
        child: (true)
            ? Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(8)),
                    Text(
                      'Welcome ${FirebaseAuth.instance.currentUser.displayName}',
                      style: Styles.textHeadLine2,
                    ),
                    Padding(padding: EdgeInsets.all(16)),
                    Text(
                      'Continue Reading',
                      style: Styles.textHeadLine3,
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PDFViewerCachedFromUrl(
                                    url: RorCardModel.rorUrl4,
                                  )),
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Styles.colorPlaceHolderBarDark,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/myrhapsody.appspot.com/o/images%2F16510_junecover-min.png?alt=media&token=4fe6d24f-9fa0-4d7a-abe1-e7d85fd73191'),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rhapsody August Issue',
                                    style: Styles.textRegularMedium,
                                  ),
                                  Padding(padding: EdgeInsets.all(4)),
                                  Text(
                                    '2 days ago',
                                    style: Styles.textDescriptiveItems,
                                  ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Padding(padding: EdgeInsets.all(8)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrow_down_circle_fill,
                                        size: 18,
                                        color: Styles.colorPrimary,
                                      ),
                                      Text(
                                        'English',
                                        style: Styles.textDescriptiveItems,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Page 15',
                                    style: Styles.textDescriptiveItems,
                                  ),
                                  Padding(padding: EdgeInsets.all(6)),
                                  TextButton(
                                      style: Styles.primaryButtonStyle,
                                      onPressed: () {},
                                      child: Text(
                                        'Continue',
                                        style:
                                            TextStyle(color: Styles.colorWhite),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(16)),
                    Text(
                      'Latest Issues',
                      style: Styles.textHeadLine3,
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            RorCardModel.sampleList.length,
                            (index) => RorCard(
                              model: RorCardModel.sampleList[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(16)),
                    Text(
                      'Distribution Contacts',
                      style: Styles.textHeadLine3,
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    EmptyStateScreen(
                      title: 'No distribution contacts',
                      subTitle: 'Add contacts to enable Rhasphody distribution',
                      assetImageUrl:
                          'assets/emptyStates/distribution_contacts.png',
                      actionButton: TextButton(
                        onPressed: () {
                          showDialog(
                              barrierColor:
                                  Styles.colorSecondary.withOpacity(0.9),
                              context: context,
                              builder: (BuildContext context) {
                                return new AlertDialog(
                                  backgroundColor: Styles.colorSecondaryLight,
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Create Contact',
                                            style: Styles.textRegularMedium,
                                          ),
                                          Text(
                                              'Create contacts to easily distribute Rhaspody to users in different languages'),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(
                                                onPressed: () {},
                                                style:
                                                    Styles.secondaryButtonStyle,
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                      color: Styles.colorWhite),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                style:
                                                Styles.primaryButtonStyle,
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Styles.colorWhite),
                                                ),
                                              ),
                                              /*TextButton(
                                                onPressed: () {},
                                                style:
                                                    Styles.primaryButtonStyle,
                                                child: Text(
                                                  'Save & Continue',
                                                  style: TextStyle(
                                                      color: Styles.colorWhite),
                                                ),
                                              ),*/
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        style: Styles.primaryButtonStyle,
                        child: Text(
                          'Add Contact',
                          style: TextStyle(color: Styles.colorWhite),
                        ),
                      ),
                    )
                    /*Container(
                     // color: Colors.grey,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Image.asset('assets/emptyStates/distribution_contacts.png'),
                      ),
                    ),*/
                  ],
                ),
              )
            : PlaceHolderHome(),
      ),
    );
  }
}


class RorCardModel {
  final String title;
  final String imageUrl;

  RorCardModel({@required this.title, @required this.imageUrl});

  static const String rorUrl1 =
      'https://storage.googleapis.com/myrhapsody.appspot.com/AUTO_DOWNLOADED/August/Arabic.pdf?GoogleAccessId=firebase-adminsdk-bup7x%40myrhapsody.iam.gserviceaccount.com&Expires=16447014000&Signature=N4I%2FsjfouLYtGbt4Dd7NnKEpncahaziv24g8JXEHwH20m8Ws7stPlDuAArwCc1AkqC1D4WDsrAQQWl5hxhHKo6a8NJQkyd2rT5N3yywK%2F1jlIDx5wABUI5jBNnxbczheVuPDci5zWkawInAWLbeNkR5ayFhAYrqOg9YK59B73eI6CUxBks%2BwEEWB%2F2DkiZTWaeGCl82oS66%2FSi4pml8P1HUql91k71clxT7GKQ%2F9jglBbJW3XkdxLu92pMbuNUk%2B3OJeGD64C38MXh6J0GHzel%2BSXcNQg%2BOookV9A7aqiLxM3eN0rJPYImQcNSwc1M6444gr%2BrNqzTYEGel2PMyFaw%3D%3D';
  static const String rorUrl2 =
      'https://storage.googleapis.com/myrhapsody.appspot.com/AUTO_DOWNLOADED/August/Czech.pdf?GoogleAccessId=firebase-adminsdk-bup7x%40myrhapsody.iam.gserviceaccount.com&Expires=16447014000&Signature=V%2BEl4ffXdJ%2FzNbP9jUxXE0GxNH0P5Nd9K%2Bg32dRepp1YXQLK0rd29ZV4nFh4gXgdK9KcXcrc1BF86fmzuD6oecTFMP%2BgPN%2FynOu8qPKdQp79O9ZTO50MbhJFkmdZFO1wrq4N2Dv%2FclBu2HFhuQfBzQ4FivU%2FHzvpwybSwiUiBhd7q%2Fr%2BEDjXYGujlBenJgfhMqs7LrgDXWEfAU3%2BsHkBuYtWZzhCj7N4j5dJ64TSLnIA8wSO7FlR2YkvMCuzIJokvO3eRz9C9Emi8rF7l%2B6gcdfWZe67clF8D6JqbAmRY2%2FsM4lsbcYpHLCcf6gX1yua4vEDDZzBZMgGnj7ruDZvwA%3D%3D';
  static const String rorUrl3 =
      'https://storage.googleapis.com/myrhapsody.appspot.com/AUTO_DOWNLOADED/August/French.pdf?GoogleAccessId=firebase-adminsdk-bup7x%40myrhapsody.iam.gserviceaccount.com&Expires=16447014000&Signature=prEuXaln3DeklPw5uxtDNp2wp5VArx%2FZI7f%2B1WQTH%2B9hcTJi4s3Aa7GxnWp8rh3rbpvMGUM4f3rkzLTCK7UQrJ3Y%2FBbFVehQOi7xZxZErQxFzauFvjCowwXT9KWodm7LzCVqBD4HuhlsRohy%2Fg3tb9ZD49ASBusrur%2FgxIvIcuutwI5vqj0eWAfuL%2BpGL7xJEJJ6Sr3SheyRL%2BvfHpAV7kLjz3UV36C22h7ehNr7UJW%2BVEgsJbWphSU5qluPXMq5nshUXwMwDnbyzDmAahikf3wvJtnfqMcU0nHsbDnobkK6EtCvXUimISwdGS1vVXgY6SpThsW7yJfgD3gV%2BmWeJQ%3D%3D';
  static const String rorUrl4 =
      'https://storage.googleapis.com/myrhapsody.appspot.com/AUTO_DOWNLOADED/August/Edo.pdf?GoogleAccessId=firebase-adminsdk-bup7x%40myrhapsody.iam.gserviceaccount.com&Expires=16447014000&Signature=dRRXS8Ynihn1w%2BpVB4qKOzhZRmWOYSzMJeJwi%2B%2FS2WyPyVHq0ugQKIFh04%2BUKc0dxidpKQbgMUGBO0KR6udrLJ3WWyIdLCpmx3HV%2F44E5K6p718%2BSjHpxByfxAAE4F5Der7zOi%2BbL846FtisUB7T6YT3Kr2KwHdmMgOJDKjdPdkMboV7CGHh999S%2FA0RN5q2NIlPawXspPMLowTIXEw52IRogokNMdhFLWkaL3FXVn70KFxEJSljkloRYPNnn9uCxKbqFbSNQUkfhue%2Ffz6nSGKtcz2GScwQtVs1unfm6y6pRUaB3VwDykYTRVSCOyUUACWz1%2BVZIq%2FaF5M26coa3A%3D%3D';
  static const String rorUrl5 =
      'https://storage.googleapis.com/myrhapsody.appspot.com/AUTO_DOWNLOADED/August/Ange.pdf?GoogleAccessId=firebase-adminsdk-bup7x%40myrhapsody.iam.gserviceaccount.com&Expires=16447014000&Signature=PHQHumcQ5t5hfFAm8ei3PQAd5UqTi%2FVi5GsyNMU33t9Qz0pEJ5NJLMqwTj1MZc9h9k2JVTSUzbNJRX%2FPRes9OtuQjuaxKD7jwbyqSvDHo36PPUNtIb5h6d3U6AdcbUO8Rm3aan%2F2RUw2F1OmCNUNZKAu0cklBaFS5iBB6tApG6IZf6OY2gQWHlstgNgpDMPL8ljCGBr4PWgFOfriykh7%2BMKw18lk6CWKOF1yAt%2F42ALtkdns%2Bz7OrZZQoQrwpW%2B1LLk2ORzUGLtc7dRNUtbZnurBPRbb92BriFb8PYj6Ew2PIA4EGOx3idGab5xRvErmFXAPh8G09RJX6VFL6XLzCA%3D%3D';
  static List<RorCardModel> sampleList = [
    RorCardModel(
        title: 'MOUNT ARARAT, ROR AUGUST 2021 Issue',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/myrhapsody.appspot.com/o/images%2Fmay-ror-cover_300x_cropped_top.jpg?alt=media&token=d8adf8a6-fd47-48f5-b95b-abfdd69eb3fc'),
    RorCardModel(
        title: 'ZACCHAEUS TREE, ROR July 2021 Issue',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/myrhapsody.appspot.com/o/images%2Fror-july-2021.jpeg?alt=media&token=eab0fd3b-138d-4bef-b886-e83c1317caaa'),
    RorCardModel(
        title: 'MOUNT OF TEMPTATION, ROR June 2021 Issue',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/myrhapsody.appspot.com/o/images%2F16510_junecover-min.png?alt=media&token=4fe6d24f-9fa0-4d7a-abe1-e7d85fd73191'),
    RorCardModel(
        title: 'VIA DOLOROSA, ROR May 2021 Issue',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/myrhapsody.appspot.com/o/images%2Fmay-ror-cover_300x_cropped_top.jpg?alt=media&token=d8adf8a6-fd47-48f5-b95b-abfdd69eb3fc'),
    RorCardModel(
        title: 'ZACCHAEUS TREE, ROR July 2021 Issue',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/myrhapsody.appspot.com/o/images%2F16510_junecover-min.png?alt=media&token=4fe6d24f-9fa0-4d7a-abe1-e7d85fd73191')
  ];
}

class RorCard extends StatelessWidget {
  final RorCardModel model;

  const RorCard({
    @required this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PDFViewerCachedFromUrl(
                    url: RorCardModel.rorUrl5,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Styles.colorPlaceHolderBarDark,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(this.model.imageUrl),
                ),
              ),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.22,
            ),
            Padding(
              padding: EdgeInsets.all(2),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Text(
                this.model.title,
                style: Styles.textDescriptiveItems.copyWith(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlaceHolderHome extends StatelessWidget {
  const PlaceHolderHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(8)),
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.6,
            color: Styles.colorPlaceHolderBackground,
          ),
          Padding(padding: EdgeInsets.all(16)),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Styles.colorPlaceHolderBackground,
          ),
          Padding(padding: EdgeInsets.all(8)),
          Container(
            color: Styles.colorPlaceHolderBackground,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Padding(padding: EdgeInsets.all(16)),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Styles.colorPlaceHolderBackground,
          ),
          Padding(padding: EdgeInsets.all(8)),
          Container(
            color: Styles.colorPlaceHolderBackground,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Padding(padding: EdgeInsets.all(16)),
          Container(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Styles.colorPlaceHolderBackground,
          ),
          Padding(padding: EdgeInsets.all(8)),
          Container(
            color: Styles.colorPlaceHolderBackground,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ],
      ),
    );
  }
}
