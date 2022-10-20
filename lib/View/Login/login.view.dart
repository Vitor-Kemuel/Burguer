import 'package:burguer/Components/Alert/alert_dialog.component.dart';
import 'package:burguer/Components/Buttons/elevated_button_custom.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/Core/Theme/colors.theme.dart';
import 'package:burguer/FormController/login.controller.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:burguer/Service/form.service.dart';
import 'package:burguer/View/Register/register.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  var authenticationService = AuthenticationService();
  bool isLoading = false;

  final LoginControllers controller = LoginControllers();

  @override
  Widget build(BuildContext context) {
    var formService = FormService(formKey: _formKey);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 243, 33, 33),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: backgroundDark,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Column(
                  children: [
                    const Expanded(
                      child: CircleAvatar(
                        minRadius: 70,
                        maxRadius: 100,
                        backgroundColor: Color.fromARGB(181, 255, 255, 255),
                        child: Icon(
                          Icons.fastfood_rounded,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        labelText: 'E-mail',
                        prefixIcon: Icons.person_outlined,
                        inputType: TextInputType.emailAddress,
                        controller: controller.email,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'E-mail é obrigatório'),
                          EmailValidator(errorText: 'E-mail incorreto')
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        labelText: 'Senha',
                        controller: controller.password,
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        isTextInputSecret: true,
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: 'Senha é obrigatória',
                          ),
                          MinLengthValidator(
                            6,
                            errorText: 'Senha deve ter no minímo 6 caracteres',
                          ),
                        ]),
                      ),
                    ),
                    (isLoading)
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: ElevatedButtonCustom(
                              textButton: 'Login',
                              onPressed: () {
                                _login(formService, context);
                              },
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ainda não tem cadastro?',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const UserRegistration(),
                              ),
                            );
                          },
                          child: const Text(
                            'Cadastra-se',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login(FormService formService, BuildContext context) async {
    setState(() => isLoading = true);
    if (formService.validateForm()) {
      formService.saveForm();
      try {
        await authenticationService.login(
          context,
          controller.email!.text,
          controller.password!.text,
        );
      } on AuthenticationException catch (e) {
        setState(() => isLoading = false);
        showDialog(
          context: context,
          builder: (_) => showAlertDialog(context, e.message),
        );
      }
    }

    setState(() => isLoading = false);
  }
}
