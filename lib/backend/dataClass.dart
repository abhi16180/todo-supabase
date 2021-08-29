import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';
import 'package:get/get.dart';

class DataClass {
  final client = Get.find<SupabaseClient>();
  final box = Get.find<GetStorage>();
  Future addToDb(String heading, String description) async {
    var uid = box.read('uid');
    final existingTasks = await client
        .from('todo')
        .select('taskArray')
        .match({'uid': uid}).execute();
    List data = [];
    if ((existingTasks.data[0]['taskArray']) != null) {
      data = (existingTasks.data[0]['taskArray'])['tasks'];
    }

    //append new task
    data.add({
      "heading": heading,
      "description": description,
    });

    final res = await client.from('todo').update({
      "taskArray": {
        "tasks": data,
      }
    }).match({"uid": uid}).execute();
    return res.data;
  }

  Future getFromDb() async {
    var uid = box.read('uid');
    final resp = await client
        .from('todo')
        .select('taskArray')
        .match({'uid': uid}).execute();
    return resp.data;
  }

  Future deleteData(data, item) async {
    var uid = box.read('uid');
    data.removeAt(item);
    await client.from('todo').update({
      "taskArray": {
        "tasks": data,
      }
    }).match({'uid': uid}).execute();
  }
}
