//SHOULD MOVE TO CLOUD
enum Tags {
  FRONT_END,
  BACK_END,
  MIRRORS,
  BUMPERS,
  RIMS,
  WHEELS,
  ACCESSORIES,
  ELECTRICAL,
  MECHANICAL,
  PRE_2000,
  POST_2000,
}

extension Tag on Tags {
  String get name => this.toString().replaceAll("_", " ");
}
