import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          child: FadeInImage(
              placeholder: AssetImage('asssets/jar-loading.gif'),
              image: NetworkImage('http://via.placeholder.com/400x300/f6f6f6'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);
}
