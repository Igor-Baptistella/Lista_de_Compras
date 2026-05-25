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

  Future<List<dynamic>> getItems() async {

    return await databaseService.getItems();
  }

  Future addItem() async {

    if (itemController.text.isEmpty) {
      return;
    }

    await databaseService.addItem(
      itemController.text,
    );

    itemController.clear();

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
  ) async {

  final editController = TextEditingController();

  editController.text = currentName;

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: const Text('Editar Item'),

        content: TextField(

          controller: editController,

          decoration: const InputDecoration(
            labelText: 'Novo nome',
          ),
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

              await databaseService.editItem(
                id,
                editController.text,
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

                Expanded(

                  child: TextField(

                    controller: itemController,

                    decoration: const InputDecoration(
                      labelText: 'Adicionar item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

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
                            item['name'],
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