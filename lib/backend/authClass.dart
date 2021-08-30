import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';

class AuthClass {
  final _client = Get.find<SupabaseClient>();
  final box = Get.find<GetStorage>();
  Future register(String email, String password, String username) async {
    final registerResp = await _client.auth.signUp(email, password);
    var uid = await _client.auth.currentUser?.id;
    await _client.from('todo').insert({
      'uid': uid,
      "taskArray": {"tasks": []}
    }).execute();
    if (registerResp.data != null) {
      box.write('uid', uid);
      box.write('loggedin', true);
    }
    return registerResp.data;
  }

  Future login(String email, String password) async {
    final resp = await _client.auth.signIn(email: email, password: password);
    var uid = await _client.auth.currentUser?.id;
    if (resp.data != null) {
      box.write('uid', uid);
      box.write('loggedin', true);
    }
    return resp.data;
  }

  Future logout() async {
    final resp = await _client.auth.signOut();
    if (resp != null) {
      box.write('loggedin', false);
    }
    return resp;
  }
}
