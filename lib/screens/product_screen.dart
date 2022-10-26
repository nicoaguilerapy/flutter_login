import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/providers/product_form_provider.dart';
import 'package:flutter_login/widgets/widgets.dart';
import 'package:flutter_login/services/services.dart';
import 'package:flutter_login/ui/input_decoration.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productServices = Provider.of<ProductServices>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productServices.selectedProduct),
      child: _ProductScreenBody(productServices: productServices),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productServices,
  });

  final ProductServices productServices;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
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
          onPressed: () async {
            if (!productForm.isValidForm()) return;
            await productServices.saveOrCreateProduct(product);
          },
        ));
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 30),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del Producto', labelText: 'Nombre'),
              ),
              SizedBox(height: 30),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                initialValue: product.price,
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = '0';
                  } else {
                    product.price = value;
                  }
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: '\$100', labelText: 'precio'),
              ),
              SwitchListTile.adaptive(
                  value: product.available,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: productForm.updateAvailability),
              SizedBox(height: 30),
            ],
          ),
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
