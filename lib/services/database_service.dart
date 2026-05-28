import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {

  final supabase = Supabase.instance.client;

  Future addItem(
    String name,
    int quantity,
  ) async {

    final user = supabase.auth.currentUser;

    await supabase.from('shopping_items').insert({

      'user_id': user!.id,
      'name': name,
      'quantity': quantity,
    });
  }

  Future<List<dynamic>> getItems() async {

    final user = supabase.auth.currentUser;

    return await supabase
        .from('shopping_items')
        .select()
        .eq('user_id', user!.id);
  }

  Future updateItem(
    String id,
    bool checked,
  ) async {

    await supabase
        .from('shopping_items')
        .update({
          'checked': checked,
        })
        .eq('id', id);
  }

  Future deleteItem(String id) async {

    await supabase
        .from('shopping_items')
        .delete()
        .eq('id', id);
  }

  Future editItem(String id, String newName, int quantity, ) async {

    await supabase
        .from('shopping_items')
        .update({

          'name': newName,
          'quantity': quantity,
        })
        .eq('id', id);
  }
}