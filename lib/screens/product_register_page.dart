import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_engineering/screens/home_page.dart';
import '../models/delivery.dart';
import '../repositories/delivery_repository.dart';

class ProductRegisterPage extends StatefulWidget {
  ProductRegisterPage({super.key});

  final DeliveryRepository deliveryRepository = DeliveryRepository();
  List<Delivery> deliveryList = [];

  @override
  State<ProductRegisterPage> createState() => _ProductRegisterPageState();
}

class _ProductRegisterPageState extends State<ProductRegisterPage> {
  final TextEditingController productNameTextController =
      TextEditingController();
  final TextEditingController productBrandTextController =
      TextEditingController();
  final TextEditingController productWeightTextController =
      TextEditingController();
  final TextEditingController initialDateTextController =
      TextEditingController();
  final TextEditingController finalDateTextController = TextEditingController();
  final TextEditingController productReceiverTextController =
      TextEditingController();

  String? errorText = '';
  List<Delivery>? deletedDeliveryList;
  Delivery? deletedDelivery;
  int? deletedDeliveryPosition;

  @override
  void initState() {
    super.initState();
    widget.deliveryRepository.getDeliveryList().then(
      (value) {
        setState(
          () {
            widget.deliveryList = value;
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
                const SizedBox(height: 5),
                Text(
                  errorText.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red),
                ),
                const SizedBox(height: 15),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: productNameTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do Produto',
                      hintText: 'Ex. Geladeira',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: productBrandTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da marca do Produto',
                      hintText: 'Ex. Brastemp',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: productWeightTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Peso do Produto',
                      hintText: 'Ex. 50kg',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: initialDateTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data inicial do pedido',
                      hintText: 'Ex. 05/10/2023',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: finalDateTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data final para a entrega',
                      hintText: '25/10/2023',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: productReceiverTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome da receptor do Produto',
                      hintText: 'Ex. Marcos',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
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
    String productName = productNameTextController.text.toString();
    String productBrand = productBrandTextController.text.toString();
    String productWeight = productWeightTextController.text.toString();
    String initialDate = initialDateTextController.text.toString();
    String finalDate = finalDateTextController.text.toString();
    String productReceiver = productReceiverTextController.text;

    if (productName.isEmpty ||
        productBrand.isEmpty ||
        productWeight.isEmpty ||
        initialDate.isEmpty ||
        finalDate.isEmpty ||
        productReceiver.isEmpty) {
      setState(() {
        errorText = 'Preencha todos os campos!';
      });
      return;
    }

    Delivery newDelivery = Delivery(
        productName: productName,
        productBrand: productBrand,
        productWeight: productWeight,
        initialDate: initialDate,
        finalDate: finalDate,
        productReceiver: productReceiver,
        dateTime: DateTime.now());
    widget.deliveryList.add(newDelivery);

    widget.deliveryRepository.saveDeliveryList(widget.deliveryList);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
