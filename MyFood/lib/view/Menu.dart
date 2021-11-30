import 'dart:developer';
import 'package:myfood/view/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfood/models/recipe.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myfood/view/MenuDetail.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  MenuState createState() => MenuState();
}

FirebaseAuth auth = FirebaseAuth.instance;
////TextEditingController _textController = TextEditingController();
////TextEditingController _amountController = TextEditingController();
//Future getPosts() async {
//  var db = FirebaseFirestore.instance;
//  final User? user = auth.currentUser;
//  final uid = user?.uid;

//  //var ref = db.collection("Users").doc(uid).collection("Drawer");
//  //var querySnapshot = await ref.get();
//  //var totalE = querySnapshot.docs.length;
//  QuerySnapshot qn =
//      await db.collection("Users").doc(uid).collection("Drawer").get();

//  return qn.docs;
//}

//class ListBuilder extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final List<String> searchTerms = [];
//    getPosts();

//return FutureBuilder(
//  future: getPosts(),
//  builder: (_, snapshot) {
//    if (snapshot.connectionState == ConnectionState.waiting) {
//      return
//    } else {
//      return ListView.builder(
//          itemCount: snapshot.hasData ? snapshot.data.length : 0,
//          itemBuilder: (_, index) {});
//    }
//  },
//);
//Future<List<dynamic>> getGallery() async {
//  var db = FirebaseFirestore.instance;
//  final User? user = auth.currentUser;
//  final uid = user?.uid;
//  //QuerySnapshot qn  = db.collection("Users").doc(uid).collection("Drawer").get() as QuerySnapshot<Object?>;
//  QuerySnapshot qn =
//      await db.collection("Users").doc(uid).collection("Drawer").get();

//  return qn.docs;
//}

class MenuState extends State<Menu> {
  //@override
  //void initState() {
  //  super.initState();
  //  // docList = getDoc();
  //  FutureBuilder(
  //    future: getDoc(),
  //    builder: (context, snapshot) {
  //      if (snapshot.hasData) {
  //        //List<QueryDocumentSnapshot> data =
  //        //    snapshot.data as List<QueryDocumentSnapshot>;
  //        docList = snapshot.data;
  //        return docList;
  //      }
  //    },
  //  );
  //}

  Future<List<QueryDocumentSnapshot>> getDoc() async {
    List<QueryDocumentSnapshot> docList = [];
    var db = FirebaseFirestore.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    await db
        .collection("Users")
        .doc(uid)
        .collection("Drawer")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        docList.add(doc);
      });
    });
    print(docList);
    return docList;
  }

  //@override
  //void initState() {
  //  super.initState();
  //  FutureBuilder(
  //    future: getDoc(),
  //    builder: (_, snapshot) {
  //      if (snapshot.hasData) {
  //        List<QueryDocumentSnapshot> data =
  //            snapshot.data as List<QueryDocumentSnapshot>;
  //        //for (var i in docList) {
  //        print(data);
  //      }
  //      return Text("");
  //    },
  //  );
  //}

  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: deviceWidth,
          //height: deviceHeight,
          color: Colors.teal[50],
          child: Column(children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              new Container(
                //margin: const EdgeInsets.only(bottom: 0),
                child: InkWell(
                    onTap: () {
                      //print("hi");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    },
                    child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(width: 3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        margin: EdgeInsets.only(
                            left: deviceWidth * .05,
                            right: deviceWidth * .15,
                            top: deviceHeight * .03),
                        width: deviceWidth * .15,
                        height: deviceHeight * .045,
                        //padding: EdgeInsets.only(left: 100),
                        child: Center(
                          child: Text(
                            "Back",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                                //fontSize: deviceWidth * .03,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ))),
              ),
              Center(
                  child: new Container(
                height: 60,
                width: 100,
                margin: EdgeInsets.only(
                    left: deviceWidth * .0005, top: deviceWidth * .06),
                child: Image(
                  image: AssetImage("assets/images/logo_MyFood.png"),
                ),
              )),
            ]),
            new Expanded(child: RecipeCard()),
            FutureBuilder(
              future: getDoc(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> data =
                      snapshot.data as List<QueryDocumentSnapshot>;
                  for (var i in data) {
                    print(i["Name"]);
                    //return Text(data[0].id);
                  }
                }
                return Text("");
                //else {
                //  print(snapshot.data);
                //  return CircularProgressIndicator();
                //}
              },
            )
          ]),
        ));
  }
}

class RecipeCard extends StatelessWidget {
  //const MyStatelessWidget({Key key}) : super(key: key);
  final List<RecipeModel> recipesList = [
    RecipeModel(
      "Pumpkin Pie",
      4,
      200,
      "20 minutes",
      "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2014/3/6/0/RF0104_From-Scratch-Pumpkin-Pie_s4x3.jpg.rend.hgtvcom.616.462.suffix/1433678596474.jpeg",
      [
        '8 large eggs',
        '1 tsp. Dijon mustard',
        'Kosher salt and pepper',
        '1 tbsp. olive oil or unsalted butter',
        '2 slices thick-cut bacon, cooked and broken into pieces',
        '2 c. spinach, torn',
        '2 oz. Gruyère cheese, shredded',
      ],
      [
        "Preheat oven to 425 degrees F. Whisk pumpkin, sweetened condensed milk, eggs, spices and salt in medium bowl until smooth. Pour into crust. Bake 15 minutes.",
        "Reduce oven temperature to 350 degrees F and continue baking 35 to 40 minutes or until knife inserted 1 inch from crust comes out clean. Cool. Garnish as desired. Store leftovers covered in refrigerator."
      ],
      [
        "Large mixing bowl",
        "Medium mixing bowl",
        "Kitchen scale",
        "Liquid measuring cups",
        "Dry measuring cups and spoons",
        "Spatula for stirring",
      ],
    ),
    RecipeModel(
      "Roast Chicken w/ Basil",
      5,
      450,
      '20 minutes',
      "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2015/7/21/2/FNM_090115-Roast-Basil-Chicken-with-Basil-Baby-Potatoes-Recipe_s4x3.jpg.rend.hgtvcom.616.462.suffix/1437663053111.jpeg",
      [],
      [],
      [],
    ),
    RecipeModel(
        "Lasagna",
        2,
        900,
        "20 minutes",
        "https://www.modernhoney.com/wp-content/uploads/2019/08/Classic-Lasagna-14-scaled.jpg",
        [],
        [],
        []),
    RecipeModel(
        "Broccoli Salad",
        3,
        170,
        "20 minutes",
        "https://www.paleorunningmomma.com/wp-content/uploads/2021/06/broccoli-salad-7.jpg",
        [],
        [],
        []),
    RecipeModel(
      "Taco Salad",
      3.5,
      180,
      "20 minutes",
      "https://dinnerthendessert.com/wp-content/uploads/2021/01/Taco-Salad-7.jpg",
      [],
      [],
      [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(0),
      child: new ListView.builder(
          itemCount: recipesList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildRecipeCard(context, index)),
    );
  }

  Widget buildRecipeCard(BuildContext context, int index) {
    final RecipeModel = recipesList[index];
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    //if () {}
    return new InkWell(
        onTap: () {
          //print(docList)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuDetail(recipeModel: RecipeModel)));
        },
        child: Container(
          height: 300,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
          //decoration: BoxDecoration(
          //  borderRadius: BorderRadius.circular(15),
          //  image: DecorationImage(
          //      image: NetworkImage(
          //          "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
          //      fit: BoxFit.fitWidth),
          //),
          child: Stack(children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: RecipeModel.uri,
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(RecipeModel.uri),
                          fit: BoxFit.cover)),
                ),
                //child: Hero(
                //  tag: RecipeModel.uri,
                //  child: Image(
                //      image: NetworkImage(RecipeModel.uri), fit: BoxFit.fill),
                //),
              ),
            ),

            //borderRadius: BorderRadius.all(Radius.circular(20),

            //height: 220,
            //decoration: BoxDecoration(
            //    //color: Colors.red,
            //image: DecorationImage(
            //    image: NetworkImage(RecipeModel.uri),
            //    fit: BoxFit.fill),

            Positioned(
              top: 130,
              right: 10,
              left: 10,
              height: 158,
              child: Card(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                clipBehavior: Clip.antiAlias,
                //margin: const EdgeInsets.only(top: 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: //Stack(
                    //  alignment: Alignment.center,
                    //  children: [
                    //    Ink.image(
                    //      image: NetworkImage(Recipe.uri),
                    //      fit: BoxFit.cover,
                    //    ),
                    Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 4.0, right: 10, left: 5),
                        child: Row(children: <Widget>[
                          Container(
                              width: deviceWidth * .73,
                              child: Flexible(
                                  //color: Colors.amber,
                                  //width: deviceWidth,
                                  child: Text(
                                RecipeModel.title,
                                maxLines: 2,
                                //softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                  fontSize: 22,
                                  //color: Color.fromRGBO(229, 115, 44, 1.0),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                          Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                        ),
                        child: Row(children: <Widget>[
                          RatingBar.builder(
                            initialRating: RecipeModel.rating,
                            minRating: 1,
                            itemSize: 25,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          //Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 4.0, right: 10, left: 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${RecipeModel.calories.toStringAsFixed(0)} Calories",
                              style: new TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                //color: Color.fromRGBO(229, 115, 44, 1.0),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
