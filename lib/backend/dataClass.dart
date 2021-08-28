import 'package:get/get_core/src/get_main.dart';
import 'package:supabase/supabase.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

class DataClass {
  final client = Get.find<SupabaseClient>();

  Future addToDb(String heading, String description) async {
    /*final _resp = await client.from('todo').insert({
      "taskArray": {
        "task": [
          {"heading": title, "description": task},
          {"heading": title, "description": task}
        ]
      }
    }).execute();
     print(_resp.data);
    return _resp.data; */
    final existingTasks =
        await client.from('todo').select('taskArray').eq('id', 5).execute();
    var data = ((existingTasks.data as List<dynamic>)[0]['taskArray']['task']);
    //append new task
    data.add({
      "heading": heading,
      "description": description,
    });

    final res = await client.from('todo').update({
      "taskArray": {
        "task": data,
      }
    }).match({"id": 2}).execute();
    return res.data;
  }

  Future getFromDb() async {
    final resp = await client
        .from('todo')
        .select('taskArray')
        .match({'id': 2}).execute();
    print(resp.data);

    return resp.data;
  }

  Future deleteData(title) async {
    final resp =
        await client.from('todo').delete().eq('title', title).execute();
  }
}
