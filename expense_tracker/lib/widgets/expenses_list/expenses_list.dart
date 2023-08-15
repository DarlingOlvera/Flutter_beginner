import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;
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
        itemBuilder: (context, index) => ExpenseItem(expenses[index]));
  }
}
