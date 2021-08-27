import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'screens/home.dart';

const supabaseUrl = 'https://bihcfbjfnraqriqnpefm.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNzc5NzQ4NCwiZXhwIjoxOTQzMzczNDg0fQ.Qtoh3Z2N1JTCvr1mviI1dNfpldS7boJ0r3tJT5gGBHc';

void main() async {
  Get.put<SupabaseClient>(SupabaseClient(supabaseUrl, supabaseKey));
  runApp(
    MaterialApp(
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
