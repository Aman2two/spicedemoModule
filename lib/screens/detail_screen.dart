import 'package:demo_spice/Models/model.dart';
import 'package:demo_spice/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/widget_util.dart';

class DetailScreen extends StatelessWidget {
  // This will contain info of data which is clicked on first screen
  final ItemModel data;

  const DetailScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(data.name, false, context),
        body: Container(
          color: Colors.grey[100],
          child: ListView(
            children: [
              //Used For showing image
              imageWidget(data),
              //Used for showing price and discount values
              _priceChild(),
              SizedBox(height: 15),
              // Used for showing best price info
              _detailDescChild(),
              SizedBox(height: 15),
              // Used for showing return info
              _exchangeDetailChild(),
              SizedBox(height: 15),
              // Used for showing different sizes and add to bag and wishlist button
              _sizeChild(),
              SizedBox(height: 15),
              // Used for showing description of product
              _descriptionWidget(),
              // Used for spacing between widgets
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceChild() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              data.name,
              style: TextStyle(fontSize: 17.0.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              data.shortDesc,
              style: TextStyle(fontSize: 13.0.sp, color: Colors.grey[700]),
            ),
            SizedBox(
              height: 30.0,
            ),
            data.discountPercentage.isEmpty
                ? Text(data.OrigPrice, style: TextStyle(fontSize: 14))
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("₹${data.OrigPrice}",
                          style: TextStyle(
                              fontSize: 17.0.sp, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 3,
                      ),
                      Text("₹${data.DiscountPrice}",
                          style: TextStyle(
                              fontSize: 13.0.sp,
                              color: Colors.grey[700],
                              decoration: TextDecoration.lineThrough),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "(${data.discountPercentage} $textOff)",
                        style: TextStyle(fontSize: 13.0.sp, color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              inclusiveText,
              style: TextStyle(
                  color: Colors.green[600], fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _detailDescChild() => Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Text(
            data.longDesc.discountDetails,
            style: TextStyle(color: Colors.grey[700], fontSize: 12.0.sp),
          ),
        ),
      );

  Widget _exchangeDetailChild() => Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
            child: Row(
              children: [
                Icon(Icons.swap_vert_circle_outlined),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  data.longDesc.exchangeDtls,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
      );

  Widget _sizeChild() => Container(
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectSize,
                  style: TextStyle(
                      fontSize: 11.0.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  selectChart,
                  style: TextStyle(
                      fontSize: 11.0.sp,
                      color: Colors.pink[600],
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
                children: data.longDesc.sizeDetails
                    .map((e) => _sizeWidget((e as Map).keys.first.toString()))
                    .toList()),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlineButton(
                  onPressed: () {},
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border, size: 18.0.sp),
                        SizedBox(width: 2.0),
                        Text(
                          wishListText,
                          style:
                              TextStyle(fontSize: 14.0.sp, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  color: Colors.pink[400],
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: 18.0.sp,
                        ),
                        SizedBox(width: 2.0),
                        Text(
                          addToBag,
                          style: TextStyle(fontSize: 14.0.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _sizeWidget(String text) => Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.2),
            borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
          ),
          child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Text(text,
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0.sp))),
        ),
      );

  Widget _descriptionWidget() => Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.longDesc.details
                .map((e) => _detailChild(e as Map))
                .toList(),
          ),
        ),
      );

  Widget _detailChild(Map data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.keys.first.toString(),
            style: TextStyle(color: Colors.black87,fontSize: 12.0.sp,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(data.values.first.toString(),
              style: TextStyle(color: Colors.grey[700],fontSize: 12.0.sp)),
          SizedBox(
            height: 7.0,
          ),
        ],
      );
}
