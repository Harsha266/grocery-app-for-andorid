import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourcartapp/your_cart_app/ui/delivery_address.dart';
import 'package:yourcartapp/your_cart_app/ui/item_detail_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var firestoredb = Firestore.instance.collection("cart_items").snapshots();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Text("Add to your Cart"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.cancel),
              title: Text('Cancel', style: TextStyle(color: Colors.black),)),
          BottomNavigationBarItem(icon: Icon(Icons.payment),
              title: Text(
                'Makepayment', style: TextStyle(color: Colors.black),)),
        ],
        onTap: (int index) {
          if (index == 0) {
            Navigator.pop(context);
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeliveryAddress()));
          }
        },
      ),
      body: StreamBuilder(
          stream: firestoredb,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else if (snapshot.data == null)
              return Text("No item in your Cart");
            else
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, int index) {
                    return Column(
                      children: [
                    Container(
                          height: 130,
                          child: InkResponse(
                            onTap: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>ItemDetails(
                                  snapshot.data.documents[index]['image'] ,
                                  snapshot.data.documents[index]['prize'],
                                  snapshot.data.documents[index]['itemname'],
                                  snapshot.data.documents[index]['itemquantity'])));
                            },
                            child: Card(
                              elevation: 9,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Image(image: AssetImage(
                                        snapshot.data.documents[index]['image'])),
                                    title: Text(snapshot.data
                                        .documents[index]['itemname'],
                                        style: TextStyle(fontSize: 20)),
                                    subtitle: Text("${snapshot.data
                                        .documents[index]['itemquantity']}",
                                        style: TextStyle(fontSize: 15)),
                                    trailing: Text("₹${snapshot.data
                                        .documents[index]['prize']}",
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 300.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: <Widget>[
                                        IconButton(icon: Icon(Icons.delete),
                                            onPressed: () async =>
                                            {
                                              await Firestore.instance
                                                  .runTransaction((
                                                  Transaction myTransaction) async {
                                                await myTransaction.delete(
                                                    snapshot.data.documents[index]
                                                        .reference);
                                              })
                                            }),
                                        IconButton(icon: Icon(Icons.edit),
                                            onPressed: () async =>
                                            {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemupdateDetails(snapshot.data.documents[index]['image'] ,
                                                  snapshot.data.documents[index]['prize'],
                                                  snapshot.data.documents[index]['itemname'],
                                                  snapshot.data.documents[index]['itemquantity'],
                                              snapshot.data.documents[index].documentID)))

                                            })
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),


                      ],
                    );
                         });

          }),


    );;
  }


}
class amount extends StatelessWidget {
  final index;
  final snapshot;

  const amount({Key key, this.index, this.snapshot}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
            elevation: 9,
            child: ListTile(
              title: Text("Total Amount"),
              trailing: Text("₹${totalamount(snapshot, index)}"),
            ),

          )


    );
  }
  totalamount(snapshot,index) {
    int Totalamount=0 ;
    for(int i=0;i<=snapshot.data.documents.length;i++){
      Totalamount=Totalamount+snapshot.data.documents[index]['prize'];

    }
    return Totalamount;

  }
}
