import 'package:flutter/material.dart';
import 'package:flutter_login/services/auth_services.dart';
import 'package:flutter_login/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('Inicio'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
              onPressed: () {
                authServices.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(
                Icons.login_outlined,
              ),
            )
          ],
        ),
        body: ListView.builder(
            itemBuilder: (BuildContext, int index) => GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'product'),
                  child: ProductCard(),
                )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ));
  }
}
