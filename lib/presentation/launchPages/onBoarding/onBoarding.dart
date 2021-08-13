import 'package:MyRhapsody/presentation/core/customStyles.dart';
import 'package:MyRhapsody/theme/styles.dart';
import 'package:flutter/material.dart';

import 'onBoardingItems.dart';

class OnBoardingPage extends StatelessWidget {
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("MyRhapsody"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
        backgroundColor: Styles.colorSecondary,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageViewController,
          itemBuilder: (context, index) {
            return Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    Items.welcomeData[index]['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    Items.welcomeData[index]['image'],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<Widget>.generate(
                              3,
                              (indicator) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                height: 10.0,
                                width: 10.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: indicator == index
                                      ? Styles.colorSecondary
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 18),
                          child: Text(
                            Items.welcomeData[index]['text'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xff485068),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        index != 2
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/signInPage');
                                    },

                                    // splashColor: const Color(0xFFf857a6),
                                    color: Styles.colorPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Skip",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      if (index < 2) {
                                        _pageViewController.animateToPage(
                                            index + 1,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.ease);
                                      } else {}
                                    },
                                    // splashColor: const Color(0xFFf857a6),
                                    color: Styles.colorPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      alignment: Alignment.center,
                                      child: Text(
                                        index != 2
                                            ? 'Next Step'
                                            : "Let's Get Started",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : FlatButton(
                                onPressed: () {
                                  if (index < 2) {
                                    _pageViewController.animateToPage(index + 1,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  } else {
                                    Navigator.pushNamed(context, '/signInPage');
                                  }
                                },
                                // splashColor: const Color(0xFFf857a6),
                                color: Styles.colorPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Container(
                                  width: 150,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Let's Get Started",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
