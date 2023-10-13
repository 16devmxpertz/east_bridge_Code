import 'package:east_bridge/Advisory/screens/serviceList.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/Advisory/screens/service.dart';

class ServiceFormScreen extends StatefulWidget {
  @override
  _ServiceFormScreenState createState() => _ServiceFormScreenState();
}



class _ServiceFormScreenState extends State<ServiceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
   List<Service> _services = []; // Define _services list here

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Service'),
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
      // Form is valid, save the service
      Service newService = Service(
        title: _titleController.text,
        description: _descriptionController.text,
        amount: double.parse(_amountController.text),
        fees: double.parse(_feesController.text),
        type: _typeController.text,
      );

      // Add the new service to the list
      _services.add(newService);

      // Clear the input fields
      _titleController.clear();
      _descriptionController.clear();
      _amountController.clear();
      _feesController.clear();
      _typeController.clear();


 Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceListScreen(services: _services),
        ),
      );
      // Optionally, you can show a confirmation message

      // Navigate to the service list screen and pass the list of services
     
    }
  }
}
