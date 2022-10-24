import 'package:flutter/material.dart';
import 'package:flutter_login/screens/screens.dart';
import 'package:flutter_login/services/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => AuthService())],
        child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos',
      initialRoute: 'checking',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScren(),
        'register': (_) => RegisterScreen(),
        'checking': (_) => CheckAuthScreen(),
        'product': (_) => ProductScreen()
      },
      scaffoldMessengerKey: NotificationsServices.messageKey,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[350],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigoAccent),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigoAccent, elevation: 0)),
    );
  }
}
