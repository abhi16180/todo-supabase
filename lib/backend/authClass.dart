import 'package:get/get.dart';
import 'package:supabase/supabase.dart';

import '../main.dart';

class AuthClass {
  final _client = Get.find<SupabaseClient>();

  Future register(String email, String password, String username) async {
    final registerResp = await _client.auth.signUp(email, password);
    var uid = await _client.auth.currentUser?.id;
    await _client.from('todo').insert({
      'uid': uid,
      "taskArray": {"tasks": []}
    }).execute();

    print(email);
    print(password);
    return registerResp.data;
  }
}
