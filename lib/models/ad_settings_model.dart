class AdSettings {
  bool? singleCoverRewardedAd;
  int? singleCoverRewardedAdX;
  bool? downloadAllCoversRewardedAd;
  bool? exportedImageRewardedAd;
  int? exportedImageRewardedAdX;

  AdSettings(
      {this.singleCoverRewardedAd,
      this.singleCoverRewardedAdX,
      this.downloadAllCoversRewardedAd,
      this.exportedImageRewardedAd,
      this.exportedImageRewardedAdX});

  AdSettings.fromJson(Map<String, dynamic> json) {
    singleCoverRewardedAd = json['singleCoverRewardedAd'];
    singleCoverRewardedAdX = json['singleCoverRewardedAdX'];
    downloadAllCoversRewardedAd = json['downloadAllCoversRewardedAd'];
    exportedImageRewardedAd = json['exportedImageRewardedAd'];
    exportedImageRewardedAdX = json['exportedImageRewardedAdX'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['singleCoverRewardedAd'] = this.singleCoverRewardedAd;
    data['singleCoverRewardedAdX'] = this.singleCoverRewardedAdX;
    data['downloadAllCoversRewardedAd'] = this.downloadAllCoversRewardedAd;
    data['exportedImageRewardedAd'] = this.exportedImageRewardedAd;
    data['exportedImageRewardedAdX'] = this.exportedImageRewardedAdX;
    return data;
  }
}