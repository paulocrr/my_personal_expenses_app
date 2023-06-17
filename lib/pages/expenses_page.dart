import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_personal_expenses_app/services/expenses_service.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Gastos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: 800,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding:
                          const EdgeInsets.only(top: 24, right: 16, left: 16),
                      children: [
                        TextFormField(
                          controller: _descriptionController,
                          decoration:
                              const InputDecoration(labelText: 'Descripcion'),
                          validator: RequiredValidator(
                              errorText: 'Este campo es requerido'),
                        ),
                        TextFormField(
                          controller: _amountController,
                          decoration:
                              const InputDecoration(labelText: 'amount'),
                          keyboardType: TextInputType.number,
                          validator: RequiredValidator(
                              errorText: 'Este campo es requerido'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final expensesService = ExpensesService();

                              try {
                                await expensesService.saveSpent(
                                  description: _descriptionController.text,
                                  amount: double.parse(_amountController.text),
                                );

                                if (context.mounted) {
                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Gasto guardado'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('No se pudo guardar el gasto'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Agregar Gasto'),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
