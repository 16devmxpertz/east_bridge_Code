import 'package:east_bridge/Advisory/screens/Service_Edit_Screen.dart';
import 'package:east_bridge/Advisory/screens/service.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/Advisory/screens/service.dart';
import 'package:flutter/material.dart';


class ServiceListScreen extends StatefulWidget {
  final List<Service> services;

  ServiceListScreen({required this.services});

  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service List'),
      ),
      body: ListView.builder(
        itemCount: widget.services.length,
        itemBuilder: (context, index) {
          Service service = widget.services[index];
          return ListTile(
            title: Text(service.title),
            subtitle: Text(service.description),
            trailing: Text('\$${service.amount.toStringAsFixed(2)}'),
            onTap: () => _navigateToEditScreen(context, service, index),
          );
        },
      ),
    );
  }

  Future<void> _navigateToEditScreen(
      BuildContext context, Service service, int index) async {
    Service updatedService = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ServiceEditScreen(service: service),
      ),
    );

    if (updatedService != null) {
      // Update the service data in the list
      setState(() {
        widget.services[index] = updatedService;
      });
    }
  }
}
