class categoriesList{
  String category;
  String images;
  static List<categoriesList> getcategoriesList()=>[
    categoriesList("Cereals", "images/back.jpg"),
    categoriesList("fruits", "images/groceries.jpg"),
    categoriesList("Branded Items", "images/brand_f.jpg"),
    categoriesList("Household Items", "images/home.jpg"),
    categoriesList("Vegetables", "images/veg.jpg"),
    categoriesList("Cosmetics", "images/be.jpg"),
    categoriesList("Non-veg", "images/nonveg.jpg"),
    categoriesList("snacks", "images/snacks.jpg"),



  ];

  categoriesList(this.category, this.images);

}