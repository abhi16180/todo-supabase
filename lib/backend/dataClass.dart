import 'package:get/get_core/src/get_main.dart';
import 'package:supabase/supabase.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

class DataClass {
  final client = Get.find<SupabaseClient>();

  Future addToDb(String heading, String description) async {
    var uid = client.auth.currentUser!.id;
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
    var uid = client.auth.currentUser!.id;
    final resp = await client
        .from('todo')
        .select('taskArray')
        .match({'uid': uid}).execute();
    return resp.data;
  }

  Future deleteData(title) async {
    final resp =
        await client.from('todo').delete().eq('title', title).execute();
  }
}
