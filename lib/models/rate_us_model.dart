class RateUs {
  bool? imageSavedFlow;
  int? imageSavedFlowFirstX;
  int? imageSavedFlowSecondX;
  bool? highlightCoverSavedFlow;
  int? highlightCoverSavedFlowFirstX;
  int? highlightCoverSavedFlowSecondX;
  bool? highlightCoverPackSavedFlow;
  int? highlightCoverPackSavedFlowFirstX;
  int? highlightCoverPackSavedFlowSecondX;

  RateUs(
      {this.imageSavedFlow,
      this.imageSavedFlowFirstX,
      this.imageSavedFlowSecondX,
      this.highlightCoverSavedFlow,
      this.highlightCoverSavedFlowFirstX,
      this.highlightCoverSavedFlowSecondX,
      this.highlightCoverPackSavedFlow,
      this.highlightCoverPackSavedFlowFirstX,
      this.highlightCoverPackSavedFlowSecondX});

  RateUs.fromJson(Map<String, dynamic> json) {
    imageSavedFlow = json['imageSavedFlow'];
    imageSavedFlowFirstX = json['imageSavedFlowFirstX'];
    imageSavedFlowSecondX = json['imageSavedFlowSecondX'];
    highlightCoverSavedFlow = json['highlightCoverSavedFlow'];
    highlightCoverSavedFlowFirstX = json['highlightCoverSavedFlowFirstX'];
    highlightCoverSavedFlowSecondX = json['highlightCoverSavedFlowSecondX'];
    highlightCoverPackSavedFlow = json['highlightCoverPackSavedFlow'];
    highlightCoverPackSavedFlowFirstX =
        json['highlightCoverPackSavedFlowFirstX'];
    highlightCoverPackSavedFlowSecondX =
        json['highlightCoverPackSavedFlowSecondX'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageSavedFlow'] = this.imageSavedFlow;
    data['imageSavedFlowFirstX'] = this.imageSavedFlowFirstX;
    data['imageSavedFlowSecondX'] = this.imageSavedFlowSecondX;
    data['highlightCoverSavedFlow'] = this.highlightCoverSavedFlow;
    data['highlightCoverSavedFlowFirstX'] = this.highlightCoverSavedFlowFirstX;
    data['highlightCoverSavedFlowSecondX'] =
        this.highlightCoverSavedFlowSecondX;
    data['highlightCoverPackSavedFlow'] = this.highlightCoverPackSavedFlow;
    data['highlightCoverPackSavedFlowFirstX'] =
        this.highlightCoverPackSavedFlowFirstX;
    data['highlightCoverPackSavedFlowSecondX'] =
        this.highlightCoverPackSavedFlowSecondX;
    return data;
  }
}
