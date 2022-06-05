class Stores {
  late String storeID;
  late String storeName;
  late int isActive;
  Images? images;

  Stores({required this.storeID, required this.storeName, required this.isActive, this.images});

  Stores.fromJson(Map<String, dynamic> json) {
    storeID = json['storeID'];
    storeName = json['storeName'];
    isActive = json['isActive'];
    images = json['images'] != null ? Images.fromJson(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeID'] = storeID;
    data['storeName'] = storeName;
    data['isActive'] = isActive;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    return data;
  }
}

class Images {
  String? banner;
  String? logo;
  String? icon;

  Images({required this.banner, required this.logo, required this.icon});

  Images.fromJson(Map<String, dynamic> json) {
    banner = json['banner'];
    logo = json['logo'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['banner'] = banner;
    data['logo'] = logo;
    data['icon'] = icon;
    return data;
  }
}
