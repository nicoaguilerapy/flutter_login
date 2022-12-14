import 'package:flutter/material.dart';
import 'package:flutter_login/services/services.dart';
import 'package:flutter_login/providers/login_form_provide.dart';
import 'package:flutter_login/widgets/widgets.dart';
import 'package:flutter_login/ui/input_decoration.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 250,
            ),
            CardContainer(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: _LoginForm(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            TextButton(
              onPressed: () =>
                  Navigator.restorablePushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      Colors.blueAccent.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                'Ya tengo una cuenta',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'ejemplo@ejemplo.com',
                  labelText: 'Correo electronico',
                  prefixIcon: Icons.alternate_email),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El Valor no es valido';
              },
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '********',
                  labelText: 'Contrase??a',
                  prefixIcon: Icons.password),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if (value != null && value.length >= 6) return null;
                return 'La contrase??a debe ser mayor a 6';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      // ignore: non_constant_identifier_names
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValid()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.popAndPushNamed(context, 'home');
                      } else {
                        print(errorMessage);
                        loginForm.isLoading = false;
                      }

                      loginForm.isLoading = false;
                    },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.blueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Container(
                  child: Text(
                    loginForm.isLoading ? 'Espera' : 'Ingresar',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
