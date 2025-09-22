
import 'dart:convert';

enum LoadStatus {idle, loading, success, error }

List<Breed> breedFromJson(String str) => List<Breed>.from(json.decode(str).map((x) => Breed.fromJson(x)));

String breedToJson(List<Breed> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Breed {
  Eight weight;
  Eight height;
  int id;
  String name;
  String bredFor;
  String breedGroup;
  String lifeSpan;
  String temperament;
  String origin;
  String referenceImageId;
  Image image;

  Breed({
    required this.weight,
    required this.height,
    required this.id,
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.temperament,
    required this.origin,
    required this.referenceImageId,
    required this.image,
  });

  factory Breed.fromJson(Map<String, dynamic> json) => Breed(
    weight: json["weight"] != null ? Eight.fromJson(json["weight"]) : Eight(imperial: '', metric: ''),
    height: json["height"] != null ? Eight.fromJson(json["height"]) : Eight(imperial: '', metric: ''),
    id: json["id"] ?? 0,
    name: json["name"] ?? '',
    bredFor: json["bred_for"] ?? '',
    breedGroup: json["breed_group"] ?? '',
    lifeSpan: json["life_span"] ?? '',
    temperament: json["temperament"] ?? '',
    origin: json["origin"] ?? '',
    referenceImageId: json["reference_image_id"] ?? '',
    image: json["image"] != null ? Image.fromJson(json["image"]) : Image(id: '', width: 0, height: 0, url: ''),
  );


  Map<String, dynamic> toJson() => {
    "weight": weight.toJson(),
    "height": height.toJson(),
    "id": id,
    "name": name,
    "bred_for": bredFor,
    "breed_group": breedGroup,
    "life_span": lifeSpan,
    "temperament": temperament,
    "origin": origin,
    "reference_image_id": referenceImageId,
    "image": image.toJson(),
  };
}

class Eight {
  String imperial;
  String metric;

  Eight({
    required this.imperial,
    required this.metric,
  });

  factory Eight.fromJson(Map<String, dynamic> json) => Eight(
    imperial: json["imperial"],
    metric: json["metric"],
  );

  Map<String, dynamic> toJson() => {
    "imperial": imperial,
    "metric": metric,
  };
}

class Image {
  String id;
  int width;
  int height;
  String url;

  Image({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    width: json["width"],
    height: json["height"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "width": width,
    "height": height,
    "url": url,
  };
}
