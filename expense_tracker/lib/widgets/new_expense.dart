import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.others;

  void _openDatePicker() async {
    final today = DateTime.now();
    final firstDate = DateTime(today.year - 1, today.month, today.day);
    final lastDate = DateTime(today.year + 1, today.month, today.day);

    //los tipo Future en Dart son como las promesas en js, incluso se puede usar async await
    /* showDatePicker(
        context: context,
        initialDate: today,
        firstDate: firstDate,
        lastDate: lastDate).then((value){

        }); */
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: firstDate,
        lastDate: lastDate);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //.trim() quita espacios al inicio y final de una string
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input', style: GoogleFonts.raleway()),
          content: Text('Please make sure all the fields are valid.',
              style: GoogleFonts.raleway()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'Okay',
                style: GoogleFonts.raleway(),
              ),
            ),
          ],
        ),
      );
      return;
    }

    //here...
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory),
    );

    Navigator.pop(context);
  }

  //importante decirle a flutter que elimine el TextEditingController una vez ya no
  //esé siendo usado, de otro modo seguiría ocupando memoria
  //en este caso debería eliminarse una vez cerrado el modal
  //Para eso se hace uso de dispose()
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //contiene informacion extra acerca de elementos UI que esten tapando la UI de la aplicación, como el teclado por ejemplo
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity, //para que tome toda la altura de la pantalla
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, keyboardSpace + 16),
            child: Column(children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        decoration: InputDecoration(
                            label: Text('Expense name',
                                style: GoogleFonts.raleway())),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          prefixText: '\$ ',
                          label: Text(
                            'Expense amount',
                            style: GoogleFonts.raleway(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: InputDecoration(
                      label:
                          Text('Expense name', style: GoogleFonts.raleway())),
                ),
              if (width >= 600)
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = val;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                            style: GoogleFonts.raleway(),
                          ), // el ! fuerza a flutter a entender que el valor no es null
                          IconButton(
                            onPressed: _openDatePicker,
                            icon: const Icon(Icons.calendar_month_rounded),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              else
                Row(children: [
                  //el textfield estaba causando el mismo error que Listview al estar dentro de un column
                  //por eso, el uso de Expanded
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: InputDecoration(
                        prefixText: '\$ ',
                        label: Text(
                          'Expense amount',
                          style: GoogleFonts.raleway(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                          style: GoogleFonts.raleway(),
                        ), // el ! fuerza a flutter a entender que el valor no es null
                        IconButton(
                          onPressed: _openDatePicker,
                          icon: const Icon(Icons.calendar_month_rounded),
                        )
                      ],
                    ),
                  ),
                ]),
              //Dropdown button
              if (width >= 600)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Save expense',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          //clase proporcionada por flutter
                          Navigator.pop(
                              context); //pop remueve el overlay de la pantalla
                        },
                        child: Text(
                          'Cancel',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                                style: GoogleFonts.raleway(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = val;
                        });
                      },
                    ),
                  ],
                ),
              if (width < 600)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          'Save expense',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          //clase proporcionada por flutter
                          Navigator.pop(
                              context); //pop remueve el overlay de la pantalla
                        },
                        child: Text(
                          'Cancel',
                          style:
                              GoogleFonts.raleway(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                )
            ]),
          ),
        ),
      );
    });
  }
}
