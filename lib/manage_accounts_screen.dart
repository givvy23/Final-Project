import 'package:flutter/material.dart';

class ManageAccountsScreen extends StatefulWidget {
  @override
  _ManageAccountsScreenState createState() => _ManageAccountsScreenState();
}

class _ManageAccountsScreenState extends State<ManageAccountsScreen> {
  final List<Map<String, dynamic>> _accounts = [
    {'name': 'BCSMTSC', 'email': 'bcsmtsc@gmail.com', 'status': 'Pending'},
    {'name': 'BADACO', 'email': 'badaco@gmail.com', 'status': 'Pending'},
    {'name': 'BEPMPC', 'email': 'beppmpc@gmail.com', 'status': 'Pending'},
    {'name': 'BMC', 'email': 'bmc@gmail.com', 'status': 'Pending'},
    {'name': 'BTHSMPC', 'email': 'bthsmpc@gmail.com', 'status': 'Pending'},
    {'name': 'SIDC', 'email': 'sidc@gmail.com', 'status': 'Pending'},
    {'name': 'LIMCOMA', 'email': 'limcoma@gmail.com', 'status': 'Pending'},
    {'name': 'PGPMC', 'email': 'pgpmc@gmail.com', 'status': 'Pending'},
  ];

  String? _selectedStatus = "All";

  void _approveAccount(String accountName) {
    setState(() {
      var account = _accounts.firstWhere((element) => element['name'] == accountName);
      account['status'] = 'Approved'; 

      _accounts.removeWhere((element) => element['name'] == accountName);
      _accounts.add(account);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$accountName has been approved')),
      );
    });
  }

  void _showDeleteConfirmationDialog(String accountName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete the account of $accountName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _accounts.removeWhere((element) => element['name'] == accountName);
                });
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$accountName has been deleted')),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> get filteredAccounts {
    if (_selectedStatus == "Approved") {
      return _accounts.where((account) => account['status'] == 'Approved').toList();
    } else if (_selectedStatus == "Pending") {
      return _accounts.where((account) => account['status'] == 'Pending').toList();
    }
    return _accounts; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), 
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), 
        child: AppBar(
          centerTitle: true,
          title: const Text('PCLEDO', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF003366)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(36), 
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,  
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Manage Accounts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),  
              ],
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Text('Filter:'),
                    DropdownButton<String>(
                      value: _selectedStatus,
                      items: <String>['All', 'Approved', 'Pending'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatus = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAccounts.length,
                itemBuilder: (context, index) {
                  final account = filteredAccounts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5, 
                    color: Colors.white, 
                    child: ListTile(
                      title: Text(account['name']!),
                      subtitle: Text(account['email']!),
                      trailing: account['status'] == 'Pending'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check_circle),
                                  color: Colors.green,
                                  onPressed: () => _approveAccount(account['name']!),
                                  tooltip: 'Approve this account',
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () => _showDeleteConfirmationDialog(account['name']!),
                                  tooltip: 'Delete this account',
                                ),
                              ],
                            )
                          : Text(
                              'Approved', 
                              style: TextStyle(color: Colors.green),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
