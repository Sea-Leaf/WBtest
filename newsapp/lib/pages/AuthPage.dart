import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:newsapp/services/AuthService.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Авторизация"),
          ),
          body: FormBuilder(
            key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                      name: "Email",
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 20),
                        ),
                        labelText: "Почта",
                      ),
                  ),
                  SizedBox(height: 8),
                  FormBuilderTextField(
                    name: "Password",
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 20),
                      ),
                      labelText: "Пароль",
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                      onPressed: (){
                        authService.signIn(emailController.text, passwordController.text);
                      },
                      icon: Icon(Icons.login, size: 30),
                      label: Text("Войти", style: TextStyle(fontSize: 20),)
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
