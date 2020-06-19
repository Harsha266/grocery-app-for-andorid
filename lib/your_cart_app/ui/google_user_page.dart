import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:yourcartapp/your_cart_app/model_your_cart/category_lists.dart';
import 'package:yourcartapp/your_cart_app/ui/add_to_cart_screen.dart';
import 'package:yourcartapp/your_cart_app/ui/fruits_screen.dart';
import 'package:yourcartapp/your_cart_app/ui/login_screen.dart';
import 'package:yourcartapp/your_cart_app/ui/sign_in.dart';
class GoogleShoppingList extends StatefulWidget {
  @override
  _GoogleShoppingListState createState() => _GoogleShoppingListState();
}

class _GoogleShoppingListState extends State<GoogleShoppingList> {

  final List<categoriesList> category= categoriesList.getcategoriesList();

  Future getCurrentgoggleuser() async{
    return await FirebaseAuth.instance.currentUser();
  }
  Widget displaygoogleuserinfo(context, snapshot){
    final user = snapshot.data;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                child: Image.asset("images/apple.jpg"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircleAvatar(child: user.getPhotoUrl()),
                  Text("${user.getEmail}")
                ],
              ),
              Divider(thickness: 3,),
              InkResponse(
                onTap: null,
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.white,
                      child: Icon(Icons.info_outline, size: 25, color: Colors.grey,), ),
                    title: Text("Personal Info"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 8),
                child: OutlineButton(
                  splashColor: Colors.grey,
                  shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Sign Out", style: TextStyle(fontSize: 15)),
                  onPressed: (){
                    signOutGoogle().whenComplete(() => {
                      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName)),
                    });

                  },
                ),
              )

            ],
          )

      ),
    );


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
            future: getCurrentgoggleuser(),
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                return displaygoogleuserinfo(context, snapshot);}
              else{
                return CircularProgressIndicator();
              }
            }),

      ),

      appBar: AppBar(

          title: Text('Your Cart'),
          centerTitle: true,
          backgroundColor: Colors.red.shade800

      ),
      bottomNavigationBar:
      BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', style: TextStyle(color: Colors.black),), ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Add to cart', style: TextStyle(color: Colors.black),) ),

        ], onTap: (int index)=>{
        if(index==0){


        }else if(index==1){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>CartScreen()))
        }else{

        }
      },),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width,
                height: 230,
                child: imagecarsoelslider(context),
              ),
              Expanded(
                child: Container(
                  child:  categorygridview(context),

                ),
              )

            ],
          ),
        ),
      ),

    );
  }
  Widget imagecarsoelslider(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Carousel(
        images: [
          AssetImage('images/carasoel2.jpg'),
          AssetImage('images/carasoel3.jpg'),
          AssetImage('images/carasoel4.jpg'),
          AssetImage('images/carasouel1.jpg'),
          AssetImage('images/carasoel5.jpg'),
        ],
        dotColor: Colors.red,
        boxFit: BoxFit.fill,
        autoplay: true,
        autoplayDuration: Duration(seconds: 5),
        animationCurve: Curves.easeInOutCubic,
        indicatorBgPadding: 3,

      ),

    );

  }// carsoel slider
  Widget categorygridview(BuildContext context){

    return  GridView.count(crossAxisCount: 2,
      childAspectRatio: (MediaQuery.of(context).size.width/2)/200,

      shrinkWrap: true,
      children: List.generate(category.length, (index){
        return GridTile(
          child: InkResponse(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>FruitsScreen(Categoryselected: category[index].category,)));

            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(

                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: AssetImage(category[index].images), height: 100,width:100,),
                          Divider(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical:5),
                            child: Text(category[index].category, style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),),
                          ),
                        ]),
                  ),
                ),
              ),

            ),
          ),
        );
      })
      ,);
  }





}




