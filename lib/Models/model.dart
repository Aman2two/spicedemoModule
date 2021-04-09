import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ItemModel {
  String imageURL;
  String name;
  String shortDesc;
  String OrigPrice;
  String DiscountPrice;
  String discountPercentage;
  LongDesc longDesc;

  ItemModel(this.imageURL, this.name, this.shortDesc, this.OrigPrice,
      this.DiscountPrice, this.discountPercentage, this.longDesc);

  factory ItemModel.fromJson(Map<String, dynamic> map) {
    return ItemModel(
      map['imageURL'],
      map['name'],
      map['shortDesc'],
      map['OrigPrice'],
      map['DiscountPrice'],
      map['discountPercentage'],
      LongDesc.fromJson(map['longDesc']),
    );
  }
}

@JsonSerializable()
class LongDesc {
  String discountDetails;
  String exchangeDtls;
  List<dynamic> sizeDetails;
  String seller;
  List<dynamic> details;

  LongDesc(this.discountDetails, this.exchangeDtls, this.sizeDetails,
      this.seller, this.details);

  factory LongDesc.fromJson(Map<String, dynamic> map) {
    return LongDesc(map['discountDetails'], map['exchangeDtls'],
        map['sizeDetails'], map['seller'], map['details']);
  }
}
