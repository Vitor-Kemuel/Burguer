import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Components/EditAddress/edit_address.component.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddressCard extends StatelessWidget {
  final AddressModel? model;

  const AddressCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 73, 73, 73),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(30, 10, 10, 10),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                model!.name!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(
                Icons.house_sharp,
                color: Colors.white,
                size: 32.0,
              ),
              title: Text(
                "${model!.publicPlace}, ${model!.number}",
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${model!.district} - ${model!.city}",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onLongPress: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => EditAddress(
                    model: model!,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
