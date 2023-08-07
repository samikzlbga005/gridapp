class special_cover_pack_model {
  String? highlightCoverPackName;
  List<HighlightsCovers>? highlightsCovers;

  special_cover_pack_model({this.highlightCoverPackName, this.highlightsCovers});

  special_cover_pack_model.fromJson(Map<String, dynamic> json) {
    highlightCoverPackName = json['highlight_cover_pack_name'];
    if (json['highlights_covers'] != null) {
      highlightsCovers = <HighlightsCovers>[];
      json['highlights_covers'].forEach((v) {
        highlightsCovers!.add(new HighlightsCovers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highlight_cover_pack_name'] = this.highlightCoverPackName;
    if (this.highlightsCovers != null) {
      data['highlights_covers'] =
          this.highlightsCovers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HighlightsCovers {
  String? highlightCoverName;
  int? order;
  String? highlightImage;

  HighlightsCovers({this.highlightCoverName, this.order, this.highlightImage});

  HighlightsCovers.fromJson(Map<String, dynamic> json) {
    highlightCoverName = json['highlight_cover_name'];
    order = json['order'];
    highlightImage = json['highlightImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['highlight_cover_name'] = this.highlightCoverName;
    data['order'] = this.order;
    data['highlightImage'] = this.highlightImage;
    return data;
  }
}