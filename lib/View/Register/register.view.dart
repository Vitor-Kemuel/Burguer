import 'package:brasil_fields/brasil_fields.dart';
import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/Buttons/elevated_button_custom.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/Core/Theme/colors.theme.dart';
import 'package:burguer/FormController/register.controller.dart';
import 'package:burguer/Model/user.model.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:burguer/Service/user_validator.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterControllers controller = RegisterControllers();

  AuthenticationService auth = AuthenticationService();

  bool isLoading = false;

  void save(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      formKey.currentState!.save();
      try {
        print(controller.cellphone!.text);
        UserModel model = UserModel(
          name: controller.name!.text.trim(),
          cellphone: controller.cellphone!.text,
          uid: null,
        );

        await auth.register(
          controller.email!.text.trim(),
          controller.password!.text.trim(),
          model,
          context,
        );
      } on AuthenticationException catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const AppBarCustom(
        title: "Cadastro",
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
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                      child: CircleAvatar(
                        maxRadius: MediaQuery.of(context).size.width / 6,
                        minRadius: 30,
                        child: const Icon(Icons.person, size: 60),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        controller: controller.name,
                        labelText: 'Nome',
                        validator: (value) => UserValidator.validarNome(value!),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        controller: controller.email,
                        inputType: TextInputType.emailAddress,
                        labelText: 'E-mail',
                        validator: (value) =>
                            UserValidator.validarEmail(value!),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        controller: controller.cellphone,
                        inputType: TextInputType.number,
                        labelText: 'Telefone',
                        validator: (value) => UserValidator.validarTelefone(value!),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        controller: controller.password,
                        labelText: 'Senha',
                        validator: (value) =>
                            UserValidator.validarSenha(value!),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextFormInputCustom(
                        controller: controller.confirmPassword,
                        labelText: 'Confirmar senha',
                        obscureText: true,
                        validator: (value) =>
                            UserValidator.validarConfirmarSenha(
                                value!, controller.password!.text),
                      ),
                    ),
                    (isLoading)
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                            child: ElevatedButtonCustom(
                              textButton: 'Cadastrar',
                              onPressed: () {
                                save(context);
                              },
                            ),
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
}
