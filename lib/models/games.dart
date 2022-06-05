class Games {
  Info? info;
  CheapestPriceEver? cheapestPriceEver;
  List<Deals>? deals;

  Games({this.info, this.cheapestPriceEver, this.deals});

  Games.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
    cheapestPriceEver =
        json['cheapestPriceEver'] != null ? CheapestPriceEver.fromJson(json['cheapestPriceEver']) : null;
    if (json['deals'] != null) {
      deals = [];
      json['deals'].forEach((v) {
        deals!.add(Deals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (cheapestPriceEver != null) {
      data['cheapestPriceEver'] = cheapestPriceEver!.toJson();
    }
    if (deals != null) {
      data['deals'] = deals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String? title;
  String? steamAppID;
  String? thumb;

  Info({this.title, this.steamAppID, this.thumb});

  Info.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    steamAppID = json['steamAppID'];
    thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['steamAppID'] = steamAppID;
    data['thumb'] = thumb;
    return data;
  }
}

class CheapestPriceEver {
  String? price;
  int? date;

  CheapestPriceEver({this.price, this.date});

  CheapestPriceEver.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['date'] = date;
    return data;
  }
}

class Deals {
  String? storeID;
  String? dealID;
  String? price;
  String? retailPrice;
  String? savings;

  Deals({this.storeID, this.dealID, this.price, this.retailPrice, this.savings});

  Deals.fromJson(Map<String, dynamic> json) {
    storeID = json['storeID'];
    dealID = json['dealID'];
    price = json['price'];
    retailPrice = json['retailPrice'];
    savings = json['savings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeID'] = storeID;
    data['dealID'] = dealID;
    data['price'] = price;
    data['retailPrice'] = retailPrice;
    data['savings'] = savings;
    return data;
  }
}
