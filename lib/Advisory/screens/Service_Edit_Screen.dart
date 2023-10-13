import 'package:east_bridge/Advisory/screens/service.dart';
import 'package:flutter/material.dart';


class ServiceEditScreen extends StatefulWidget {
  final Service service;

  ServiceEditScreen({required this.service});

  @override
  _ServiceEditScreenState createState() => _ServiceEditScreenState();
}

class _ServiceEditScreenState extends State<ServiceEditScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _feesController = TextEditingController();
  TextEditingController _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the service data passed from the list
    _titleController.text = widget.service.title;
    _descriptionController.text = widget.service.description;
    _amountController.text = widget.service.amount.toString();
    _feesController.text = widget.service.fees.toString();
    _typeController.text = widget.service.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _feesController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Fees'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter fees';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Type'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _saveService,
                  child: Text('Save Service'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveService() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, update the service details
      widget.service.title = _titleController.text;
      widget.service.description = _descriptionController.text;
      widget.service.amount = double.parse(_amountController.text);
      widget.service.fees = double.parse(_feesController.text);
      widget.service.type = _typeController.text;

      // Optionally, you can show a confirmation message

      // Navigate back to the service list screen with the updated service
      Navigator.pop(context, widget.service);
    }
  }
}
