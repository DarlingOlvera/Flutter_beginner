import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.others),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Book',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _expenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(onPressed: _expenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            const Text('chart'),
            //cuando hay casos donde una columna tiene otra columna dentro, flatter
            //no sabe como manejar los espacios para ambas, se puede solucionar
            //haciendo un wrap en la columna interna con el widget Expanded
            Expanded(child: ExpensesList(expenses: _registeredExpenses))
          ],
        ));
  }
}
