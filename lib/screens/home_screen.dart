import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/database_service.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final databaseService = DatabaseService();

  final itemController = TextEditingController();

  final quantityController = TextEditingController();

  Future<List<dynamic>> getItems() async {

    return await databaseService.getItems();
  }

  Future addItem() async {

    if (itemController.text.isEmpty) {
      return;
    }

    await databaseService.addItem(itemController.text,

      int.tryParse(
            quantityController.text,
          ) ??
          1,
    );

    itemController.clear();

    quantityController.clear();

    setState(() {});
  }

  Future updateItem(
    String id,
    bool value,
  ) async {

    await databaseService.updateItem(
      id,
      value,
    );

    setState(() {});
  }

  Future deleteItem(String id) async {

    await databaseService.deleteItem(id);

    setState(() {});
  }

  Future editItemDialog(
    String id,
    String currentName,
    int currentQuantity,
  ) async {

    final editController =
        TextEditingController();

    final quantityEditController =
        TextEditingController();

    editController.text = currentName;

    quantityEditController.text =
        currentQuantity.toString();

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Editar Item',
          ),

          content: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              // NOME
              TextField(

                controller: editController,

                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),

              const SizedBox(height: 15),

              // QUANTIDADE
              TextField(

                controller:
                    quantityEditController,

                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: 'Quantidade',
                ),
              ),
            ],
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);
              },

              child: const Text('Cancelar'),
            ),

            ElevatedButton(

              onPressed: () async {

                if (editController
                    .text
                    .isEmpty) {
                  return;
                }

                await databaseService.editItem(

                  id,

                  editController.text,

                  int.tryParse(
                        quantityEditController.text,
                      ) ??
                      1,
                );

                Navigator.pop(context);

                setState(() {});
              },

              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          '🛒 Lista de Compras',
        ),

        actions: [

          IconButton(

            onPressed: () async {

              await AuthService().signOut();

              Navigator.pushReplacementNamed(
                context,
                '/login',
              );
            },

            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            // CAMPO ADICIONAR ITEM
            Row(

              children: [

                // NOME
                Expanded(

                  child: TextField(

                    controller: itemController,

                    decoration: const InputDecoration(
                      labelText: 'Item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // QUANTIDADE
                SizedBox(

                  width: 80,

                  child: TextField(

                    controller: quantityController,

                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      labelText: 'Qtd',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                // BOTÃO
                ElevatedButton(

                  onPressed: addItem,

                  child: const Text('+'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // LISTA
            Expanded(

              child: FutureBuilder(

                future: getItems(),

                builder: (context, snapshot) {

                  // CARREGANDO
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // SEM DADOS
                  if (!snapshot.hasData ||
                      snapshot.data!.isEmpty) {

                    return const Center(
                      child: Text('Nenhum item'),
                    );
                  }

                  final items = snapshot.data!;

                  return ListView.builder(

                    itemCount: items.length,

                    itemBuilder: (context, index) {

                      final item = items[index];

                      return Card(

                        child: ListTile(

                          leading: Checkbox(

                            value: item['checked'],

                            onChanged: (value) {

                              updateItem(
                                item['id'],
                                value!,
                              );
                            },
                          ),

                          title: Text(
                            '${item['name']} - ${item['quantity']}x',
                            style: TextStyle(
                            decoration: item['checked']
                                ? TextDecoration.lineThrough
                                : null,
                            ),
                           ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [

                              // BOTÃO EDITAR
                              IconButton(

                                onPressed: () {

                                  editItemDialog(
                                    item['id'],
                                    item['name'],
                                    item['quantity'],
                                  );
                                },

                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),

                              // BOTÃO DELETE
                              IconButton(

                                onPressed: () {

                                  deleteItem(item['id']);
                                },

                                icon: const Icon(
                                  Icons.delete,
                                ),
                            ),
                          ],
                        ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}