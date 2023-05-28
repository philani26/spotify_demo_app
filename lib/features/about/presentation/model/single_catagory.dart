class SingleCatagory {
  String? href;
  List<Iconss>? icons;
  String? name;
  String? type;
  String? id;

  SingleCatagory({this.href, this.icons, this.name, this.type, this.id});

  SingleCatagory.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    if (json['icons'] != null) {
      icons = <Iconss>[];
      json['icons'].forEach((v) {
        icons!.add(Iconss.fromJson(v));
      });
    }
    name = json['name'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['href'] = href;
    if (icons != null) {
      data['icons'] = icons!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}

class Iconss {
  String? url;

  Iconss({this.url});

  Iconss.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}
