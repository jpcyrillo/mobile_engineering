import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile_engineering/models/delivery.dart';
import 'package:mobile_engineering/widgets/delivery_item.dart';
import '../repositories/delivery_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 1;
  final TextEditingController deliveryController = TextEditingController();
  final DeliveryRepository deliveryRepository = DeliveryRepository();
  List<Delivery> deliveryList = [];
  List<Delivery>? deletedDeliveryList;
  Delivery? deletedDelivery;
  int? deletedDeliveryPosition;
  String? errorText;

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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Entregas'),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (Delivery delivery in deliveryList)
                        DeliveryItem(
                            delivery: delivery, deleteDelivery: deleteDelivery)
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Adicionar Entrega',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => addDelivery(),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 80,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              deliveryList.length == 1
                  ? const Text('Você possui 1 entrega pendente.')
                  : Text(
                      'Você possui ${deliveryList.length} entregas pendentes.',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  deliveryList.isNotEmpty
                      ? showDeleteAllDeliveriesDialogue()
                      : null;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.all(10),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Deletar Entregas'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addDelivery() {
    setState(
      () {
        Delivery newDelivery = Delivery(title: "$i", dateTime: DateTime.now());
        deliveryList.add(newDelivery);
        errorText = null;
      },
    );
    deliveryRepository.saveDeliveryList(deliveryList);
    i++;
  }

  void deleteDelivery(Delivery delivery) {
    deletedDelivery = delivery;
    deletedDeliveryPosition = deliveryList.indexOf(delivery);

    setState(
      () {
        deliveryList.remove(delivery);
      },
    );

    deliveryRepository.saveDeliveryList(deliveryList);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Entrega "${delivery.title}" foi removida com sucesso!'),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(
              () {
                deliveryList.insert(deletedDeliveryPosition!, deletedDelivery!);
              },
            );
            deliveryRepository.saveDeliveryList(deliveryList);
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void deleteAllDeliveries() {
    setState(
      () {
        deliveryList.clear();
      },
    );
    deliveryRepository.saveDeliveryList(deliveryList);
  }

  void showDeleteAllDeliveriesDialogue() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content:
            const Text('Você tem certeza que deseja apagar todas as entregas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllDeliveries();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Limpar tudo'),
          ),
        ],
      ),
    );
  }
}
