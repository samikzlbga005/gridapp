class cover_packs {
  String? CoverPackName;
  int? order;

  cover_packs({this.CoverPackName, this.order});

  cover_packs.fromJson(Map<String, dynamic> json) {
    CoverPackName = json['highlight_cover_pack_name'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highlight_cover_pack_name'] = this.CoverPackName;
    data['order'] = this.order;
    return data;
  }
}