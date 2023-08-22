import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    //no se recomienda usar Column para listas de las cuales no se sabe el tamaño
    //y que tengan posibilidad de ser muy grandes, ya que puede afectar el performance de la app
    //en su lugar se puede usar ListView con su metodo especial .builder que basicamente
    //le instruye a ListView  que cree los elementos de la lista solo cuando esten a punto de ser
    //visibles en pantalla.
    //ListView es scrollable por defecto
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(
                expenses[
                    index], //la key sirve como un identificador unico para el widget y la data relacionada al mismo
              ),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: Theme.of(context).cardTheme.margin,
              ),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            ));
  }
}
