
import 'package:flutter/material.dart';


class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address List Page'),
      ),
      body: Center(
        child: Text('This is a Stateful Address List Page'),
      ),
    );
  }
}
