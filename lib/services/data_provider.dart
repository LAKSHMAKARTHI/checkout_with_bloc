import 'dart:convert';
import 'package:checkout/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider<T>{
  final String type;
  final String? text;
  final int? index;
  final bool isHome;
  final int selectedindex;
  T Function(dynamic response)? res;
  DataProvider({required this.type, this.text, this.index, required this.isHome, required this.selectedindex, this.res});
}

class DataCall{
  Future<T> load<T>(DataProvider<T> resouce) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (resouce.isHome){
      if (resouce.type == "add"){
        List add = [];
        try{
          var getdata = await prefs.getString(Constant.defaultspkey);
          if (getdata != null){
            add.addAll(json.decode(getdata));
          }
          add.add({"name": resouce.text, "data": []});
          await prefs.setString(Constant.defaultspkey,json.encode(add));
        } catch (_) {
          throw Exception({'error': 'can\'t get the data'});
        }
      } else if (resouce.type == "delete"){
        List delete = [];
        try{
          String getdata = await prefs.getString(Constant.defaultspkey) as String;
          delete.addAll(json.decode(getdata));
          delete.removeAt(resouce.index as int);
          await prefs.setString(Constant.defaultspkey, json.encode(delete));
        } catch (_) {
          throw Exception({'error': 'can\'t get the data'});
        }
      }

      var data = await prefs.getString(Constant.defaultspkey);
      if (data != null){
        return resouce.res!(data);
      } else {
        return resouce.res!("[]");
      }
    } else {
      var getdata = await prefs.getString(Constant.defaultspkey);
      List things = [];
      things.addAll(json.decode(getdata as String));
      if (resouce.type == "add"){
        try{
          things[resouce.selectedindex]['data'].add({"title": resouce.text, "status": false});
          await prefs.setString(Constant.defaultspkey,json.encode(things));
        } catch (e) {
          throw Exception({'error': 'can\'t get the data'});
        }
      } else if (resouce.type == "delete"){
        try{
          things[resouce.selectedindex]['data'].removeAt(resouce.index as int);
          await prefs.setString(Constant.defaultspkey, json.encode(things));
        } catch (_) {
          throw Exception({'error': 'can\'t get the data'});
        }
      } else if (resouce.type == "status"){
        try{
          things[resouce.selectedindex]['data'][resouce.index as int]['status'] = things[resouce.selectedindex]['data'][resouce.index as int]['status'] ? false : true;
          await prefs.setString(Constant.defaultspkey, json.encode(things));
        } catch (_) {
          throw Exception({'error': 'can\'t get the data'});
        }
      } else if (resouce.type == "reset"){
        things[resouce.selectedindex]['data'].asMap().forEach((key, value) {
          things[resouce.selectedindex]["data"][key]["status"] = false;
        });
        await prefs.setString(Constant.defaultspkey,json.encode(things));
      }
      var data = await prefs.getString(Constant.defaultspkey);
      return resouce.res!(data);
    }
  }
}