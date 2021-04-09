

import 'package:demo_spice/Models/model.dart';
import 'package:flutter/cupertino.dart';

class ItemController  extends ChangeNotifier{
  List dataList=List();

  // This is updated when data is fetched from api and notify the listeners so that they can change the ui.
  updateList(List<ItemModel> data){
    this.dataList=data;
    notifyListeners();
  }

}