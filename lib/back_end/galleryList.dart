class GalleryList {
  final String image_path;

  const GalleryList({
    required this.image_path,
  });

  static GalleryList fromJson(json) => GalleryList(image_path: json['path']);
}
