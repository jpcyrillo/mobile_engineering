import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/delivery.dart';
import '../repositories/delivery_repository.dart';
import 'home_page.dart';

class ProductRegisterPage extends StatefulWidget {
  const ProductRegisterPage({super.key});

  @override
  State<ProductRegisterPage> createState() => _ProductRegisterPageState();
}

class _ProductRegisterPageState extends State<ProductRegisterPage> {
  final TextEditingController textController = TextEditingController();
  String? errorText;
  int i = 0;
  final DeliveryRepository deliveryRepository = DeliveryRepository();
  List<Delivery> deliveryList = [];
  List<Delivery>? deletedDeliveryList;
  Delivery? deletedDelivery;
  int? deletedDeliveryPosition;

  @override
  void initState() {
    super.initState();
    deliveryRepository.getDeliveryList().then(
      (value) {
        setState(
          () {
            deliveryList = value;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Nome do Produto',
                      hintText: 'Ex. Geladeira',
                      errorText: errorText,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    addDelivery();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addDelivery() {
    String productName = textController.text;

    if (productName.isEmpty) {
      setState(() {
        errorText = 'O nome do produto não pode ser vazio!';
      });
      return;
    }

    setState(
      () {
        Delivery newDelivery =
            Delivery(productName: productName, dateTime: DateTime.now());
        deliveryList.add(newDelivery);
      },
    );
    deliveryRepository.saveDeliveryList(deliveryList);
    Navigator.pop(context);
  }
}
