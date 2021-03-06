import 'package:demo_spice/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

// UI of App bar used in both screen
Widget customAppBar(String text, bool showSubHeading, BuildContext context) =>
    AppBar(
      toolbarHeight: 70.0,
      brightness: Brightness.light,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 13.0.sp),
          ),
          showSubHeading
              ? Text(
                  appBarSubHead,
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    color: Colors.grey,
                  ),
                )
              : SizedBox()
        ],
      ),
      leading: GestureDetector(
        child: Icon(
          Icons.arrow_back,
          color: Colors.grey[700],
          size: 30.0,
        ),
        onTap: () {
          showSubHeading ? SystemNavigator.pop() : Navigator.pop(context);
        },
      ),
      actions: [
        Icon(
          Icons.search,
          color: Colors.grey[700],
          size: 20.0.sp,
        ),
        SizedBox(width: 10),
        Icon(
          Icons.favorite_border,
          color: Colors.grey[700],
          size:  20.0.sp,
        ),
        SizedBox(width: 10),
        Icon(
          Icons.shopping_bag_outlined,
          color: Colors.grey[700],
          size:  20.0.sp,
        ),
        SizedBox(width: 10),
      ],
    );

// UI of image shown in both screens

Widget imageWidget(ItemModel itemModel) => Image.network(
      itemModel.imageURL,
      errorBuilder: (context, object, sta) {
        return Container(
            color: Colors.grey[300],
            child: Center(
                child: Icon(
              Icons.image_outlined,
              size: 100.0,
              color: Colors.pink[600],
            )));
      },
      fit: BoxFit.cover,
    );

Widget smallImageWidget(ItemModel itemModel) {
  return itemModel.imageURL.startsWith("http")
      ? Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(itemModel.imageURL), fit: BoxFit.fill),
          ),
        )
      : Container(
          color: Colors.grey[300],
          child: Center(
              child: Icon(
            Icons.image_outlined,
            size: 100.0,
            color: Colors.white,
          )));
  ;
}
