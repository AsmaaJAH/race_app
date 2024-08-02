class RacesDataModel {
  String? name;
  String? organizer;
  String? date;
  String? country;
  String? city;
  String? image;
  String? type;
  String? distances;

  RacesDataModel(
      {required this.name,
      this.organizer,
      required this.date,
      required this.country,
      required this.city,
      required this.image,
      required this.type,
      required this.distances});

  RacesDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    organizer = json['organizer'];
    date = json['date'];
    country = json['country'];
    city = json['city'];
    image = json['image'];
    type = json['type'];
    distances = json['distances'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['organizer'] = organizer;
    map['date'] = date;
    map['country'] = country;
    map['city'] = city;
    map['image'] = image;
    map['type'] = type;
    map['distances'] = distances;
    return map;
  }
}

class AdBannerListResponse {
  List<RacesDataModel?>? adBannerList;
  int? totalPages;
  int? totalRecords;
  AdBannerListResponse({
    this.adBannerList,
    this.totalPages,
    this.totalRecords,
  });
}
