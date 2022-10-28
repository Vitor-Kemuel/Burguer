import 'package:burguer/Components/AddressCard/address_card.component.dart';
import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Service/address.service.dart';
import 'package:burguer/Components/AddressForm/address_form.component.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Adresses extends StatefulWidget {
  const Adresses({Key? key}) : super(key: key);

  @override
  State<Adresses> createState() => _AdressesState();
}

class _AdressesState extends State<Adresses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      appBar: AppBarCustom(
        title: 'Meus endereços',
        context: context,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: AddressService().getAddress(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return const Text('Erro ao carregar dados');
          if (!snapshot.hasData) return const CircularProgressIndicator();

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (_, index) {
              return AddressCard(
                model: AddressModel.fromJson(
                  snapshot.data!.docs[index].data(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add_location_alt_outlined,
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        onPressed: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => AddressForm(),
          );
        },
      ),
    );
  }
}
