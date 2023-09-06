import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewItemScreen(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    final itemIndex = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item); //eliminar el item guardado de la memoria
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Item deleted'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _groceryItems.insert(itemIndex, item);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grocery List',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _groceryItems.isEmpty
          ? Center(
              child: Text(
                'No items to show',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.7),
                ),
                onDismissed: (direction) {
                  _removeItem(_groceryItems[index]);
                },
                child: ListTile(
                  title: Text(
                    '${_groceryItems[index].quantity} ${_groceryItems[index].name}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 16,
                        ),
                  ),
                  leading: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: _groceryItems[index].category.categoryColor,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
