import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:overtimer_mobile/screens/base_screen.dart';
import 'package:overtimer_mobile/screens/login_screen.dart';
import 'package:overtimer_mobile/services/auth_service.dart';

import 'models/user_info.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Overtimer',
      theme: ThemeData.dark(),
      home: FutureBuilder<UserInfo>(
        future: AuthService.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              if (snapshot.error is http.Response && (snapshot.error as http.Response).statusCode == 401) {
                return const LoginScreen();
              } else {
                return Scaffold(body: Center(child: Text('Erro ao acessar a API, tente novamente mais tarde!')));
              }
            }
            if (snapshot.hasData) {
              return BaseScreen(userInfo: snapshot.data!);
            } else {
              return const LoginScreen();
            }
          } else {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
