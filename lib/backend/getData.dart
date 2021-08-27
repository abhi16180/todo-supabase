import 'package:get/get_core/src/get_main.dart';
import 'package:supabase/supabase.dart';
import 'package:get/get.dart';

class GetDataClass {
  final client = Get.find<SupabaseClient>();
  Future addData() async {
    await client.from('tasktable').insert([
      {"title": "two", "task": "another tas"}
    ]).execute();
    final resp = await client.from('tasktable').select('title,task').execute();
    print(resp.data);
  }

  Future addToDb(String title, String task) async {
    final status = await client.from('tasktable').insert([
      {"title": title, "task": task}
    ]).execute();
    return status.data;
  }

  Future getFromDb() async {
    final resp = await client.from('tasktable').select('title,task').execute();
    return resp.data;
  }

  Future deleteData(title) async {
    final resp =
        await client.from('tasktable').delete().eq('title', title).execute();
  }
}
