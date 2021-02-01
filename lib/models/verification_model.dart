class VerificationModel {
  bool isValid;
  String expiresAt;
  String seed;

  VerificationModel({this.isValid, this.expiresAt, this.seed});

  VerificationModel.fromJson(Map<String, dynamic> json) {
    isValid = json['isValid'];
    expiresAt = json['expires_at'];
    seed = json['seed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isValid'] = this.isValid;
    data['expires_at'] = this.expiresAt;
    data['seed'] = this.seed;
    return data;
  }
}
