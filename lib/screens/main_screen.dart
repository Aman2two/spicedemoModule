// This class contains the first page of the application.
import 'package:demo_spice/Models/controller.dart';
import 'package:demo_spice/Models/model.dart';
import 'package:demo_spice/network/api_call.dart';
import 'package:demo_spice/utils/constants.dart';
import 'package:demo_spice/utils/widget_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';

// This widget contains the first page with list of items
class ItemsPage extends StatefulWidget {
  ItemsPage({Key key}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  @override
  void initState() {
    super.initState();
    // ApiCall to get data
    ApiCall()
        .getDataFromServer(Provider.of<ItemController>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    // Consumer is used to update the ui when value of data changes in controller class where list is updated.
    return Consumer<ItemController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: customAppBar(mainPageHeading, true, context)),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        controller.dataList.length > 0
                            ? Text(
                                mainPageSubHeading,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600]),
                              )
                            : SizedBox(),
                        controller.dataList.length > 0
                            ? Text(
                                "+${controller.dataList.length - 4} items",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink[600]),
                              )
                            : SizedBox(),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: controller.dataList.isEmpty
                          // Show loader if list is empty else show the list items
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.black12,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.pinkAccent),
                            ))
                          : MainChild(items: controller.dataList)),
                )
              ],
            ),
          ),
        ),
        // This is used to show the bottom sort and filter buttons
        bottomNavigationBar: controller.dataList.length > 0
            ? BottomAppBar(
                child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          sortImagePath,
                          width: 24,
                          color: Colors.grey[700],
                        ),
                        Text(textSort,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: Colors.grey[600],
                        ),
                        Text(textFilter,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ))
            : null,
        resizeToAvoidBottomInset: false,
      );
    });
  }
}

// This Widget have all the list items
class MainChild extends StatelessWidget {
  final List<ItemModel> items;

  const MainChild({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();
    widgets.addAll(items.map((e) => SingleItem(data: e)).toList());
    double width = MediaQuery.of(context).size.width / 2;
    double height =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 30.0,
      children: widgets,
      childAspectRatio: width / height,
    );
  }
}

// Creates the UI for single Item including its image and data

class SingleItem extends StatelessWidget {
  final ItemModel data;

  const SingleItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(data: data)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(child: smallImageWidget(data))),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          data.shortDesc,
                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                          maxLines: 1,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        data.discountPercentage.isEmpty
                            ? Text(data.OrigPrice,
                                style: TextStyle(fontSize: 14))
                            : Wrap(
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  Text("₹ ${data.OrigPrice}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("₹ ${data.DiscountPrice}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700],
                                          decoration:
                                              TextDecoration.lineThrough),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${data.discountPercentage} $textOff",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.orange[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
