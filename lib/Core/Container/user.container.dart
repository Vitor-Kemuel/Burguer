import 'package:burguer/Components/Error/error.component.dart';
import 'package:burguer/Components/LoadingPage/loading_page.component.dart';
import 'package:burguer/Model/user.model.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:burguer/View/Home/home.view.dart';
import 'package:flutter/material.dart';

class UserContainer extends StatefulWidget {
  const UserContainer({Key? key}) : super(key: key);

  @override
  State<UserContainer> createState() => _UserContainerState();
}

class _UserContainerState extends State<UserContainer> {
  AuthenticationService auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: auth.getUserInformation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          if (!snapshot.data!.admin!) {
            return HomeView();
          } else {
            return ErrorPage(stringError: "admin");
          }
        }

        if (snapshot.hasError) {
          return ErrorPage(
            stringError: snapshot.error.toString(),
          );
        }

        return const Center(
          child: Text("Algo deu errado"),
        );
      },
    );
  }
}
