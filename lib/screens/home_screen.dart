import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeapp/screens/navidrawer_screen.dart';
import '../constants.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: new AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
          // It will cover 20% of our total height
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: 36 + kDefaultPadding,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Happy Home!',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Image.asset(
                          "assets/images/logo_home.png", width: 90, height: 90,),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 120),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      height: 40,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: kPrimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: kPrimaryColor.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/ic_search.png', height: 20, width: 20,),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Recomended',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: kPrimaryColor,
                    onPressed: (){},
                    child: Text(
                      "More",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    RecomendPlantCard(
                      image: "assets/images/image_1.png",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(),
                          ),
                        );
                      },
                    ),
                    RecomendPlantCard(
                      image: "assets/images/image_2.png",
                      title: "Angelica",
                      country: "Russia",
                      price: 440,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(),
                          ),
                        );
                      },
                    ),
                    RecomendPlantCard(
                      image: "assets/images/image_3.png",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {},
                    ),
                    RecomendPlantCard(
                      image: "assets/images/image_3.png",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {},
                    ),
                    RecomendPlantCard(
                      image: "assets/images/image_3.png",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {},
                    ),RecomendPlantCard(
                      image: "assets/images/image_3.png",
                      title: "Samantha",
                      country: "Russia",
                      price: 440,
                      press: () {},
                    ),

                  ],
                ),
              ),
            ],
          ),
          ),
        );
  }
}

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(

            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                      '\$$price',
                      style: Theme
                          .of(context)
                          .textTheme
                          .button
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}

