class GalleryList {
  final String image_path;
  final String description;
  final String name;

  const GalleryList({
    required this.image_path,
    required this. description,
    required this.name

  });

  static GalleryList fromJson(json) => GalleryList(image_path: json['image'], description: json['description'], name: json['name'])
  
  
  ; //description: json['description']);
}
