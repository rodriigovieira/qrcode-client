class SeedModel {
  String seed;
  String expiresAt;
  int id;

  SeedModel({this.seed, this.expiresAt, this.id});

  SeedModel.fromJson(Map<String, dynamic> json) {
    seed = json['seed'];
    expiresAt = json['expires_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seed'] = this.seed;
    data['expires_at'] = this.expiresAt;
    data['id'] = this.id;
    return data;
  }
}