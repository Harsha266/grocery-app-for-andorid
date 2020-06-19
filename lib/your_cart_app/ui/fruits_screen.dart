import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourcartapp/your_cart_app/model_your_cart/fruitslist.dart';
import 'package:like_button/like_button.dart';
import 'package:yourcartapp/your_cart_app/ui/add_to_cart_screen.dart';
import 'package:yourcartapp/your_cart_app/ui/item_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourcartapp/your_cart_app/ui/shoppingList.dart';


class FruitsScreen extends StatefulWidget {

  final String Categoryselected;
  const FruitsScreen({Key key, this.Categoryselected}) : super(key: key);@override
  _FruitsScreenState createState() => _FruitsScreenState(Categoryselected);
}

class _FruitsScreenState extends State<FruitsScreen>
{
String Categoryselected;
var fireStoreDb=Firestore.instance.collection("cart_items").snapshots();
int _quantity=1;


_FruitsScreenState(this.Categoryselected);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.Categoryselected}"),

        centerTitle: true,
        backgroundColor: Colors.red.shade900,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search, size: 30,),
              onPressed: ()=>{
        showSearch(context: context, delegate: customSearch(widget.Categoryselected))
              })
        ],
      ),
        bottomNavigationBar:
        BottomNavigationBar(
            selectedItemColor: Colors.red,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home', style: TextStyle(color: Colors.black),) ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Add to cart', style: TextStyle(color: Colors.black),) ),
        ],
            onTap: (int index)=>{
              if(index==0){
                Navigator.pop(context, MaterialPageRoute(builder: (context)=>ShoppingList()))
              }else if(index==1){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CartScreen()))
              }else{

              }
            }
        ),
     body: Container(
                child: condition(widget.Categoryselected),
    )
   );
  }
  Widget condition( String categoryselected) {
   List selecteditems;


    if(categoryselected=='fruits'){
      selecteditems=FruitsList.getFruitsList();
    }else if(categoryselected=='Cereals'){
      selecteditems=CerealsList.getCerealsList();
    }else if(categoryselected=='Branded Items'){
      selecteditems=BrandeditemsList.getBrandeditemsList();
    }else if(categoryselected=='Household Items'){
      selecteditems=HouseholditemsList.getHousholditemsList();
    }else if(categoryselected=='Vegetables'){
      selecteditems=VegetablesList.getVegetablesList();
    }else if(categoryselected=='Cosmetics'){
      selecteditems=CosmeticsitemsList.getCosmeticsitemsList();
    }else if(categoryselected=='snacks'){
      selecteditems=snacksitemsList.getsnacksitemsList();
    }else{
      selecteditems=nonvegitemsList.getnonvegitemsList();
    }
    List<bool> _likes = List.filled(selecteditems.length,true);
   int i=0;

   return  GridView.count(crossAxisCount: 2,
      childAspectRatio: (MediaQuery.of(context).size.width/2)/320,

      shrinkWrap: true,
      children: List.generate(selecteditems.length, (index){
        return GridTile(
          child: InkResponse(
            onTap: ()=>{
              Navigator.push(context,MaterialPageRoute(builder: (context)=>
                  ItemDetails(selecteditems[index].image,selecteditems[index].prize, selecteditems[index].item, _quantity))),
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [


                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Image(image: AssetImage(selecteditems[index].image), height: 120,width:120,),
                          ),
                          Divider(
                            height: 6,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical:5),
                            child: Text(selecteditems[index].item, style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black
                            ),),
                          ),
                          Text('₹${selecteditems[index].prize}',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black
                          ),),
                          Text('${selecteditems[index].quantity}',style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.black
                          ),),
                          Flexible(
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
                "itemname" : selecteditems[index].item,
                "itemquantity" :_quantity,
                "prize" : selecteditems[index].prize,
                  "image":selecteditems[index].image,
                "timestamp" :DateTime.now()
                }).then((response) {
                print(response.documentID);
                }).catchError((onError)=>print(onError));
                },

                            ),
                          )
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





 //gridview for all items


}
class customSearch extends SearchDelegate<FruitsList>{
 final String selectedsearchitem;
  customSearch(this.selectedsearchitem);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: ()=>{
      query = ""
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>{
      close(context, null)
    });
  }

  @override
  Widget buildResults(BuildContext context) {
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List Searchitems;
    if(selectedsearchitem=='fruits'){
      Searchitems=FruitsList.getFruitsList();
    }else if(selectedsearchitem=='Cereals'){
      Searchitems=CerealsList.getCerealsList();
    }else if(selectedsearchitem=='Branded Items'){
      Searchitems=BrandeditemsList.getBrandeditemsList();
    }else if(selectedsearchitem=='Household Items'){
      Searchitems=HouseholditemsList.getHousholditemsList();
    }else if(selectedsearchitem=='Vegetables'){
      Searchitems=VegetablesList.getVegetablesList();
    }else if(selectedsearchitem=='Cosmetics'){
      Searchitems=CosmeticsitemsList.getCosmeticsitemsList();
    }else if(selectedsearchitem=='snacks'){
      Searchitems=snacksitemsList.getsnacksitemsList();
    }else{
      Searchitems=nonvegitemsList.getnonvegitemsList();
    }

    final List items= query.isEmpty? Searchitems:
    Searchitems.where((p) => p.item.toLowerCase().startsWith(query.toLowerCase())).toList();
    return items.isEmpty? Center(child: Text("No results found", style: itemtextStyle(),)):ListView.builder(
      itemCount: items.length,
        itemBuilder: (context,index){
        final itemSearch= items[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: Image(image: AssetImage(itemSearch.image),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover
                ,),


            ),
          ),
          title: Text(itemSearch.item, style: itemtextStyle(),),
        subtitle: Text('Rs.${itemSearch.prize}'),);

        });

  }
  TextStyle itemtextStyle() {
    return TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.black
    );
  }

} // search tab for all items


 //this is for Fruits screen
