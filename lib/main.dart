import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:todo/screens/register.dart';
import 'screens/home.dart';

const supabaseUrl = 'https://dppejzdqiuogmpucjqrs.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyNzIzMTc4OSwiZXhwIjoxOTQyODA3Nzg5fQ.-HTXFHBsFzxhFwyNREbTBhoHkvbAvdjOE3_6NPDt7Ho';

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
