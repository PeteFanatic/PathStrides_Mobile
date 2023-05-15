// ignore_for_file: non_constant_identifier_names

class PointShopData {
  int item_id;
  String item_name = "";
  int points;
  String item_code = "";
  int user_id;
  bool isSold = false;
  bool isClaimed = false;
  PointShopData(this.item_id, this.item_name, this.points, this.item_code,
      this.user_id, this.isSold, this.isClaimed);
}
