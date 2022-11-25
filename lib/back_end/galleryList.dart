class GalleryList {
  final String image_path;
  final String description;
  final String name;
  //final String image;

  const GalleryList({
    required this.image_path,
    required this.description,
    required this.name,
    //required this.image
  });

  static GalleryList fromJson(json) => GalleryList(
        image_path: json['image'],
        description: json['description'],
        name: json['name'],
        //image: json['image_path']
      ); //description: json['description']);
}
