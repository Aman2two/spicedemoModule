import 'dart:convert';

import 'package:demo_spice/Models/controller.dart';
import 'package:demo_spice/Models/model.dart';
import 'package:demo_spice/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiCall {
  // Get data from server and
  Future<List<ItemModel>> getDataFromServer(ItemController controller) async {
    try {
      var dio = Dio();
      Response data = await dio.get(apiUrl);
      List<dynamic> list = jsonDecode(data.toString())[dataObject];
      List<ItemModel> items = list.map((e) => ItemModel.fromJson(e)).toList();
      controller.updateList(items);
      return items;
    } catch (e) {
      print(e);
    }
  }
}
