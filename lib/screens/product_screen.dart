import 'package:flutter/material.dart';
import 'package:flutter_login/widgets/widgets.dart';
import 'package:flutter_login/services/services.dart';
import 'package:flutter_login/ui/input_decoration.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productServices = Provider.of<ProductServices>(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            ProductImage(url: productServices.selectedProduct.picture),
            Positioned(
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.white,
                    ))),
            _ProductForm()
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save_as_outlined),
          onPressed: () {},
        ));
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del Producto', labelText: 'Nombre'),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: '\$100', labelText: 'precio'),
            ),
            SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                onChanged: (value) {}),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5,
            )
          ]);
}
