class FruitsList{
  String item;
  String image;
  int prize;
  var quantity;
  FruitsList(this.item, this.image, this.prize,this.quantity);
  static List<FruitsList> getFruitsList()=>[
    FruitsList("Apple", 'images/apple.jpg', 50,'Per Kg'),
    FruitsList('Kiwi', 'images/kiwi.jpg', 30,'Per Kg'),
    FruitsList('Lemon', 'images/lemon.jpg', 10,'Per Kg'),
    FruitsList('Grapes', 'images/grapes.jpg', 40,'Per Kg'),
    FruitsList('Guava', 'images/guava.jpg', 30,'Per Kg'),
    FruitsList('Orange', 'images/orange.jpg', 30,'Per Kg')

     ];

}

class VegetablesList{
  String item;
  String image;
  int prize;
  var quantity;
  VegetablesList(this.item, this.image, this.prize,this.quantity);
  static List<VegetablesList> getVegetablesList()=>[
    VegetablesList('Tomato','images/tomato.jpg', 20,'Per Kg'),
    VegetablesList('Cabbage','images/cabbage.png',40,'Per Kg'),
    VegetablesList('Cucumber','images/cucumber.jpg',30,'Per Kg'),
    VegetablesList('Brinjal','images/brinjal.jpg',30,'Per Kg'),
    VegetablesList('Capsicum','images/capsicum.jpg',40,'Per Kg'),
    VegetablesList('Cauliflower','images/cauliflower.jpg',40,'Per Kg'),
    VegetablesList('Brocolli','images/brocoli.jpg',30,'Per Kg'),
  ];

}
class CerealsList{
  String item;
  String image;
  int prize;
  var quantity;
  CerealsList(this.item, this.image, this.prize, this.quantity);
  static List<CerealsList> getCerealsList()=>[
    CerealsList('Letensils','images/letensils.jpg', 50,'Per Kg'),
  ];


}
class HouseholditemsList{
  String item;
  String image;
  int prize;
  var quantity;
  HouseholditemsList(this.item, this.image, this.prize, this.quantity);
  static List<HouseholditemsList> getHousholditemsList()=>[
  HouseholditemsList('FruitMixer','images/Fruitmixer.jpg',100,'')
  ];

}
class CosmeticsitemsList{
  String item;
  String image;
  int prize;
  var quantity;
  CosmeticsitemsList(this.item, this.image, this.prize, this.quantity);
  static List<CosmeticsitemsList> getCosmeticsitemsList()=>[
    CosmeticsitemsList('Lipstick','images/lipstic.jpg',50,'')
  ];

}

class nonvegitemsList{
  String item;
  String image;
  int prize;
  var quantity;
  nonvegitemsList(this.item, this.image, this.prize, this.quantity);
  static List<nonvegitemsList> getnonvegitemsList()=>[
    nonvegitemsList('Chicken','images/chicken.jpg',100,'Per Kg')
  ];

}
class snacksitemsList{
  String item;
  String image;
  int prize;
  var quantity;
  snacksitemsList(this.item, this.image, this.prize, this.quantity);
  static List<snacksitemsList> getsnacksitemsList()=>[
    snacksitemsList('Lays','images/lays.jpg',10,'')
  ];
}
class BrandeditemsList{
  String item;
  String image;
  int prize;
  var quantity;
  BrandeditemsList(this.item, this.image, this.prize, this.quantity);
  static List<BrandeditemsList> getBrandeditemsList()=>[
    BrandeditemsList('Anil rava','images/anil rava.jpg',40,'Per Kg')
  ];
}
