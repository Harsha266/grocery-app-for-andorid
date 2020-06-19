import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourcartapp/your_cart_app/ui/payment_screen.dart';
class RIKeys{
  static final _scaffoldKey21=GlobalKey<ScaffoldState>();
  static final _formkey21 =GlobalKey<FormState>();
}

class DeliveryAddress extends StatefulWidget {
  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}


class _DeliveryAddressState extends State<DeliveryAddress> {


  var firestoredb = Firestore.instance.collection("user_address").snapshots();
  String nameInputController;
  String AddressInputController;
  String LandmarkInputController;
  String cityInputController;
  String DistrictInputController;
  String phonenoInputController;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  Widget _name(){
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Your Name*",
        ),
        validator: (String value){
          if(value.isEmpty) return "Name is required";

        } ,
        onSaved: (String value){ nameInputController=value;},
      ),
    );
  }
  Widget _address(){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: "Address*",
        ),
        validator: (String value){
          if(value.isEmpty) return "Address is required";

        } ,
        onSaved: (String value){ AddressInputController=value;},
      ),
    );;
  }
  Widget _landmark(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "LandMark*",
      ),
      validator: (String value){
        if(value.isEmpty) return "Landmark is required";

      } ,
      onSaved: (String value){ LandmarkInputController=value;},
    );;
  }
  Widget _city(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "City*",
      ),
      validator: (String value){
        if(value.isEmpty) return "City is required";

      } ,
      onSaved: (String value){ cityInputController=value;},
    );;
  }
  Widget _district(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "District*",
      ),
      validator: (String value){
        if(value.isEmpty) return "District is required";

      } ,
      onSaved: (String value){ DistrictInputController=value;},
    );;
  }
  Widget _phoneno(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Phone Number*",
      ),
      validator: (String value){
        if(value.isEmpty) return "Phone number is required";

      } ,
      onSaved: (String value){ phonenoInputController=value;},
    );;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: RIKeys._scaffoldKey21,

      appBar: AppBar(
        title: Text("your Cart"),
        centerTitle: false,
        backgroundColor: Colors.red.shade900,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: StreamBuilder(
            stream: firestoredb,
              builder: (context,snapshot){
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                else if (snapshot.data == null)
                  return Text("No item in your Cart");
                else
                  return ListView(
                    children: <Widget>[
                  Form(
                  key: RIKeys._formkey21,
                      child: Padding(

                        padding: const EdgeInsets.all(8.0),
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Text("Please make sure that all your entries are correct",style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black
                              )),
                            ),
                            _name(),
                            _address(),
                            _city(),
                            _district(),
                            _landmark(),
                            _phoneno(),
                            SizedBox(height: 100,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                    disabledColor: Colors.green.shade600,
                                    child: Text("Cancel", style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black
                                    )),
                                    onPressed:(){
                                      Navigator.pop(context);

                                    }),
                                RaisedButton(
                                    disabledColor: Colors.green.shade600,
                                    child: Text("Proceed", style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black
                                    )),
                                    onPressed: (){
                                      if(!RIKeys._formkey21.currentState.validate()){
                                        return;
                                      }
                                      RIKeys._formkey21.currentState.save();
                                      Firestore.instance.collection('user_address').
                                      add({
                                        "name": nameInputController,
                                        "Address":AddressInputController,
                                        "Landmark":LandmarkInputController,
                                        "city":cityInputController,
                                        "District":DistrictInputController,
                                        "phonenumber":(double.parse(phonenoInputController)*100.roundToDouble()).toString()
                                      }).then((response)  {
                                        print(response.documentID);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentScreen()));
                                      }).catchError((onError)=>print(onError));
                                    }
                                ),
                              ],
                            )],
                        ),
                      ))
                    ],
                      );

              }),
        ),
      ),

      );

  }

}


