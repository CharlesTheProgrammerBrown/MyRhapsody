import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/repositories/blocs/authenticationBloc/authentication_bloc.dart';
import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyEntity.dart';
import 'package:MyRhapsody/repositories/models/RhapsodyModel/rhapsodyModel.dart';
import 'package:MyRhapsody/services/authService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class HomePage extends StatefulWidget {
  final AuthService _authService;

  const HomePage({
    Key key,
    @required AuthService authService,
  })  : _authService = authService,
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //List<RhapsodyModel> rhapsodies = [];
  List myLanguageRhapsodies = [];
  String currentUserLanguage = "";
  bool _loadingCampaigns = true;
  int _per_page = 3;
  DocumentSnapshot _lastDocument;
  ScrollController homeViewController; //= ScrollController();
  String message = "";
  // bool _gettingMoreProducts = false;
  // bool _moreProductsAvailable = true;
  FirebaseAuth _firebaseAuth;

  _scrollListener() {
    double maxScroll = homeViewController.position.maxScrollExtent;
    double currentScroll = homeViewController.position.pixels;
    double delta = MediaQuery.of(context).size.height * 0.20;

    if (maxScroll - currentScroll <= delta) {
      setState(() {
        message = "reach the bottom";
        print(message);

        //  _getMoreRhapsodies();
      });
    }
  }

  // _getRhapsodies() async {
  //   Query docQuery = firestore
  //       .collection('rhapsodies-alt')
  //       .orderBy('createdOn', descending: true)
  //       .limit(_per_page);

  //   setState(() {
  //     _loadingCampaigns = true;
  //   });

  //   QuerySnapshot querySnapshot = await docQuery.get();

  //   // rhapsodiess = querySnapshot.docs
  //   //     .map((e) =>
  //   //         UserCampaignModel.fromEntity(UserCampaignEntity.fromSnapshot(e)))
  //   //     .toList();

  //   print("reached here, length of campaigns is ");
  //   print(rhapsodiess.length);
  //   _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
  //   print("The last document is : ${_lastDocument.data()}");

  //   setState(() {
  //     _loadingCampaigns = false;
  //     print("this is run- $_loadingCampaigns");
  //   });
  // }

  // _getMoreRhapsodies() async {
  //   QuerySnapshot querySnapshot;

  //   print("getMoreProducts called");

  //   if (_moreProductsAvailable == false) {
  //     print("No more campaigns");
  //     return;
  //   }

  //   if (_moreProductsAvailable == true) {
  //     //already made the call do nothing
  //     querySnapshot = await firestore
  //         .collection('UserCampaigns')
  //         .orderBy('campaignStartDate', descending: true)
  //         .startAfter([
  //           _lastDocument.data()['campaignStartDate'],
  //         ])
  //         .limit(_per_page)
  //         .get();
  //     //return;

  //     _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
  //     print("The new last document is : ${_lastDocument.data()}");

  //     var duplicate = rhapsodiess.where((element) =>
  //         element.campaignID == _lastDocument.data()["campaignID"]);
  //     if (duplicate.isEmpty) {
  //       rhapsodiess.addAll(querySnapshot.docs
  //           .map((e) => UserCampaignModel.fromEntity(
  //               UserCampaignEntity.fromSnapshot(e)))
  //           .toList());
  //     } else {
  //       print("duplicates found and ignored");
  //       return rhapsodiess;
  //     }
  //   }

  //   setState(() {
  //     if (querySnapshot.docs.length < _per_page) {
  //       _moreProductsAvailable = false;
  //     }
  //   });
  // }

  getRhapsoName() async {
    await FirebaseFirestore.instance
        .collection("UserCollection")
        .doc(widget._authService.getCurrentUser())
        .get()
        .then((eachDoc) {
          print("current user Language is: ${eachDoc.data()["language"]}");
      currentUserLanguage = eachDoc.data()["language"];
    });
  }

  getRhapsodyInYoLangauge() async {
    //await FirebaseFirestore.instance.collection("UserCollection").doc();
    print("getRhapsody called");
    Query docQuery = firestore
        .collection('rhapsodies-alt');
        // .where("language", isEqualTo: currentUserLanguage)
        // .orderBy("createdOn", descending:true);

    setState(() {
      _loadingCampaigns = false;
    });

    QuerySnapshot querySnapshot = await docQuery.get();

    myLanguageRhapsodies = querySnapshot.docs
        .map((e) => RhapsodyModel.fromEntity(RhapsodyEntity.fromSnapshot(e)))
        .toList();

    print("rhapsodies obtained");
    print(myLanguageRhapsodies);
  }

  @override
  void initState() {
    //_getRhapsodies();
    getRhapsoName();
    getRhapsodyInYoLangauge();

    double offsetA = 0.0;

    homeViewController = ScrollController(initialScrollOffset: offsetA);

    homeViewController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Image.asset(
        //   "assets/logos/MyRhapsody.png",
        //   fit: BoxFit.scaleDown,
        //   height: 40,
        // ),
        actions: [
          FlatButton(
            onPressed: () {
              widget._authService.signOut();
              //Phoenix();

              BlocProvider.of<AuthenticationBloc>(context).add(
                AuthenticationLoggedOut(context),
              );

              Navigator.pushNamed(context, '/signInPage');
            },
            child: Icon(Icons.menu),
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
        backgroundColor: secondaryColor,
        elevation: 0.0,
      ),
      key: const PageStorageKey<String>('page1'),
      backgroundColor: Colors.white,
      body: _loadingCampaigns == true
          ? Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Shimmer.fromColors(
                period: const Duration(seconds: 8),
                baseColor: Colors.grey[350],
                highlightColor: Colors.grey[200],
                child: const PlaceHolder(),
              ),
            )
          : ListView(controller: homeViewController, children: [
              widget._authService.getCurrentUser() != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(children: [
                        Text(
                          "Welcome ${FirebaseAuth.instance.currentUser.displayName}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        // CircleAvatar(
                        //   backgroundImage:
                        //       AssetImage("assets/images/userPlaceholder.jpg"),
                        // ),
                      ]),
                    )
                  : Container(),
              //  StreamBuilder(
              //    stream: FirebaseFirestore.instance.collection("rhapsodies-alt").doc().
              //    builder: (BuildContext, snapshot){
              //    return
              //  })
              // Image.asset("assets/rorImages/july.jpeg"),
              // Image.asset("assets/rorImages/june.png"),
              // Image.asset("assets/rorImages/may.jpg"),

              myLanguageRhapsodies.length == 0
                  ? Center(
                      child: Text("No Rhapsodies"),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: myLanguageRhapsodies.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: RhapsodyCardWidget(
                            indexedUserCampaign: myLanguageRhapsodies[index],
                            context: context,
                          ),
                        );
                      },
                    ),
            ]),
    );
  }
}

class RhapsodyCardWidget extends StatefulWidget {
  final RhapsodyModel indexedUserCampaign;
  final BuildContext context;

  const RhapsodyCardWidget({
    this.indexedUserCampaign,
    this.context,
  });

  @override
  _RhapsodyCardWidgetState createState() => _RhapsodyCardWidgetState();
}

class _RhapsodyCardWidgetState extends State<RhapsodyCardWidget> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = widget.indexedUserCampaign.url;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var dir = (await getApplicationDocumentsDirectory()).path;
    var req = await HttpClient().getUrl(Uri.parse(url));
    var response = await req.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    File file = File('$dir/$filename');

    return file.writeAsBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ReadRhpasodyScreen(
                    pathPDF: pathPDF,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 8.0,
          shadowColor: Colors.grey,
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: CachedNetworkImage(
                  imageUrl: widget.indexedUserCampaign.rhapsodyCover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.2), BlendMode.srcOver),
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Image.asset("assets/images/bannerPlaceholder.png"),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/bannerPlaceholder.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 8.0,
                ),
                child: Column(
                  children: const [
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      // height: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalHeaderLineDivider extends StatelessWidget {
  const HorizontalHeaderLineDivider({
    this.label,
    this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Divider(
                color: const Color(0xFF861388),
                height: height,
                thickness: 2,
              ),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),
              child: Divider(
                color: const Color(0xFF861388),
                height: height,
                thickness: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.025,
              vertical: 10),
          child: Container(
            height: 100,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
