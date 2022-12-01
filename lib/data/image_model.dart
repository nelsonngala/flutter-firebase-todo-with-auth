class ImageModel {
  final String imgPath;
  String id;
  ImageModel({
    required this.imgPath,
    this.id = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'imgPath': imgPath,
      'id': id,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      imgPath: map['imgPath'],
      id: map['id'],
    );
  }
}
