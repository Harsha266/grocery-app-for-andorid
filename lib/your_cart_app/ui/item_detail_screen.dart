import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
import 'package:yourcartapp/your_cart_app/model_your_cart/fruitslist.dart';
import 'package:yourcartapp/your_cart_app/ui/add_to_cart_screen.dart';
import 'package:yourcartapp/your_cart_app/ui/shoppingList.dart';
class ItemDetails extends StatefulWidget {
  final String itemimage;
  final int itemprize;
  final String itemname;
  final int itemquantity;


  ItemDetails(this.itemimage, this.itemprize, this.itemname, this.itemquantity);

  @override
  _ItemDetailsState createState() => _ItemDetailsState(itemimage,itemprize,itemname,itemquantity);
}

class _ItemDetailsState extends State<ItemDetails> {
  String itemimage;
   int itemprize;
   String itemname;
   var itemquantity;
   int _quantity=1;

  _ItemDetailsState(this.itemimage, this.itemprize, this.itemname,
      this.itemquantity);
  bool like=true;
var fireStoreDb=Firestore.instance.collection("cart_items").snapshots();
  @override
  Widget build(BuildContext context) {
    NavigatorState nav;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
      ),
      bottomNavigationBar:
      BottomNavigationBar(
        selectedItemColor: Colors.red,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', style: TextStyle(color: Colors.red),) ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Add to cart', style: TextStyle(color: Colors.red),) ),
        BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), title: Text('Add to wishList', style: TextStyle(color: Colors.red),) ),
      ],
          onTap: (int index)=>{
            if(index==0){
          nav = Navigator.of(context),
          nav.pop(),
          nav.pop(),
            }else if(index==1){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CartScreen()))
            }else {

            }
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
        child: StreamBuilder(
          stream: fireStoreDb,
          builder: (context, snapshot) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:300.0,bottom: 1, top:0),
                  child: IconButton(icon: like?
                  Icon(Icons.favorite_border, color: Colors.grey, size: 25,):
                  Icon(Icons.favorite, color: Colors.red,),
                      onPressed: (){
                    setState(() {
                      like=!like;
                    });
                    if(like=true){
                    Firestore.instance.collection("wishlist")
                        .add({
                      "itemname":itemname,
                          "quantity":_quantity,
                    "itemPrize": calculateamount(_quantity, widget.itemprize)
                    }).then((value) {
                      print(value.documentID);
                    }).catchError((onError)=>print(onError));}

                      }),
                ),

    Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Image(image: AssetImage(widget.itemimage))
                      ), Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.itemname, style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700
                            ),),
                            Text("₹${calculateamount(_quantity, widget.itemprize)}", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400
                            ),),
                          ],
                        ),


                      ),
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey
                          )

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Quantity:',style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ), ),
                              Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if(_quantity>1){
                                        _quantity--;}else{

                                        }
                                      }
                                      );

                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 60.0),
                                      child: Container(
                                        width: 30,
                                        margin: EdgeInsets.all(10),
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Center(child: Text("-", style: TextStyle(
                                          color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500
                                        ), )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0, right: 0),
                                    child: Text("${_quantity}",style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500
                                    ),),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        _quantity++;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:80.0),
                                      child: Container(
                                        width: 30,
                                        margin: EdgeInsets.all(10),
                                        height: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Center(child: Text("+", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.w500
                                        ), )),
                                      ),
                                    ),
                                  ),
                                   Row(

                                     children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: OutlineButton(
                                           splashColor: Colors.red.shade800,
                                           shape:  RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10)),
                                           highlightElevation: 10,
                                           color: Colors.red.shade800,
                                           child: Text('ADD' ,style: TextStyle(
                                               fontSize: 20,
                                               color: Colors.red.shade500
                                           ),),
                                            onPressed: (){
                                             Firestore.instance.collection("cart_items")
                                                 .add({
                                               "itemname" : widget.itemname,
                                               "itemquantity" : _quantity,
                                               "prize" : calculateamount(_quantity, widget.itemprize),
                                               "image":widget.itemimage,
                                               "timestamp" :DateTime.now()
                                             }).then((response) {
                                               print(response.documentID);
                                             }).catchError((onError)=>print(onError));
                                            }
                                       ),
                                        ),
                                     ],

                                   )
                                ],
                              )
                            ],

                          ),
                        ),


                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text("Note: As this  grocery app makes you to buy items in a large scale it doesn't allow you to buy Fruits, Vegetables, Cereals and Non- Veg below 1 Kg",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ),
                      OutlineButton(
                        splashColor: Colors.grey,
                        shape:  RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10)),

                        onPressed: ()=>{
                          Navigator.pop(context),
                        },
                        child: Text("Cancel", style: TextStyle(fontSize: 20, color: Colors.grey)),)

                    ],
                  ),
                ),
],
            );
          }
        ),
      ),
    );
  }

  calculateamount(int quantity, int prize) {
    int Prize;
    Prize=quantity*prize;
    return Prize;
  }

  Future onlikeButtontapped() {

  }
}








class ItemupdateDetails extends StatefulWidget {
  final String itemimage;
  final int itemprize;
  final String itemname;
  final int itemquantity;
  var docId;


  ItemupdateDetails(this.itemimage, this.itemprize, this.itemname, this.itemquantity, this.docId);

  @override
  _ItemupdateDetailsState createState() => _ItemupdateDetailsState(itemimage,itemprize,itemname,itemquantity,docId);
}

class _ItemupdateDetailsState extends State<ItemupdateDetails> {
  String itemimage;
  int itemprize;
  String itemname;
  var itemquantity;
  int _quantity=1;
  var docId;

  _ItemupdateDetailsState(this.itemimage, this.itemprize, this.itemname,
      this.itemquantity,this.docId);
  bool like=true;


  var fireStoreDb=Firestore.instance.collection("cart_items").snapshots();
  @override
  Widget build(BuildContext context) {
    NavigatorState nav;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
      ),
      bottomNavigationBar:
      BottomNavigationBar(
          selectedItemColor: Colors.red,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', style: TextStyle(color: Colors.red),) ),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Add to cart', style: TextStyle(color: Colors.red),) ),
          ],
          onTap: (int index)=>{
            if(index==0){
              nav = Navigator.of(context),
              nav.pop(),
              nav.pop(),
            }else {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CartScreen()))
            }
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
        child: StreamBuilder(
            stream: fireStoreDb,
            builder: (context, snapshot) {
              return ListView(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Image(image: AssetImage(widget.itemimage))
                        ), Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.itemname, style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700
                              ),),
                              Text("₹${calculateamount(_quantity, widget.itemprize)}", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400
                              ),),
                            ],
                          ),


                        ),
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.grey
                              )

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Quantity:',style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600
                                ), ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if(_quantity>1){
                                            _quantity--;}else{

                                          }
                                        }
                                        );

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 60.0),
                                        child: Container(
                                          width: 30,
                                          margin: EdgeInsets.all(10),
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Center(child: Text("-", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w500
                                          ), )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0, right: 0),
                                      child: Text("${_quantity}",style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w500
                                      ),),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          _quantity++;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(right:80.0),
                                        child: Container(
                                          width: 30,
                                          margin: EdgeInsets.all(10),
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red,
                                          ),
                                          child: Center(child: Text("+", style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w500
                                          ), )),
                                        ),
                                      ),
                                    ),
                                    Row(

                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: OutlineButton(
                                              splashColor: Colors.red.shade800,
                                              shape:  RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              highlightElevation: 10,
                                              color: Colors.red.shade800,
                                              child: Text('ADD' ,style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red.shade500
                                              ),),
                                              onPressed: (){
                                                Firestore.instance.collection("cart_items")
                                                    .document(docId)
                                                .updateData({
                                                  "itemname" : widget.itemname,
                                                  "itemquantity" : _quantity,
                                                  "prize" : calculateamount(_quantity, widget.itemprize),
                                                  "image":widget.itemimage,
                                                  "timestamp" :DateTime.now()
                                                }).then((response){
                                                  Navigator.pop(context);
                                                });
//
                                              }
                                          ),
                                        ),
                                      ],

                                    )
                                  ],
                                )
                              ],

                            ),
                          ),


                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text("Note: As this  grocery app makes you to buy items in a large scale it doesn't allow you to buy Fruits, Vegetables, Cereals and Non- Veg below 1 Kg",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                        ),
                        OutlineButton(
                          splashColor: Colors.grey,
                          shape:  RoundedRectangleBorder(

                              borderRadius: BorderRadius.circular(10)),

                          onPressed: ()=>{
                            Navigator.pop(context),
                          },
                          child: Text("Cancel", style: TextStyle(fontSize: 20, color: Colors.grey)),)

                      ],
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }

  calculateamount(int quantity, int prize) {
    int Prize;
    Prize=quantity*prize;
    return Prize;
  }


}

