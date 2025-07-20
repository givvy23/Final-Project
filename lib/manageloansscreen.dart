import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class ManageLoansScreen extends StatefulWidget {
  @override
  _ManageLoansScreenState createState() => _ManageLoansScreenState();
}

class _ManageLoansScreenState extends State<ManageLoansScreen> {
  final List<Map<String, dynamic>> _loans = [
    {'coopName': 'BCSMTSC', 'loanDate': DateTime(2025, 1, 1), 'dueDate': DateTime(2025, 7, 1), 'paymentDate': null, 'paid': false, 'loanFrequency': 'Quarterly'},
    {'coopName': 'BADACO', 'loanDate': DateTime(2025, 2, 15), 'dueDate': DateTime(2025, 8, 15), 'paymentDate': null, 'paid': false, 'loanFrequency': 'Monthly'},
    {'coopName': 'BEPMPC', 'loanDate': DateTime(2025, 3, 10), 'dueDate': DateTime(2025, 9, 10), 'paymentDate': null, 'paid': false, 'loanFrequency': 'Biannual'},
    {'coopName': 'BMC', 'loanDate': DateTime(2025, 4, 25), 'dueDate': DateTime(2025, 10, 25), 'paymentDate': null, 'paid': false, 'loanFrequency': 'Annually'},
  ];

  String? _selectedStatus = "All"; 

  Future<void> _pickPaymentDate(BuildContext context, int index) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2023, 1, 1);
    DateTime lastDate = DateTime(2025, 12, 31);

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && selectedDate != _loans[index]['paymentDate']) {
      setState(() {
        _loans[index]['paymentDate'] = selectedDate;
        _loans[index]['paid'] = selectedDate.isBefore(_loans[index]['dueDate']) || selectedDate.isAtSameMomentAs(_loans[index]['dueDate']);
      });
    }
  }

  final DateFormat dateFormat = DateFormat('MM/dd/yyyy');

  String getLoanStatus(Map<String, dynamic> loan) {
    if (loan['paymentDate'] == null) {
      return 'Pending'; 
    }
    return loan['paid'] ? 'Paid' : 'Late';
  }

  List<Map<String, dynamic>> get filteredLoans {
    if (_selectedStatus == "Paid") {
      return _loans.where((loan) => loan['paid'] == true && loan['paymentDate'] != null).toList();
    } else if (_selectedStatus == "Late") {
      return _loans.where((loan) => loan['paid'] == false && loan['paymentDate'] != null).toList();
    } else if (_selectedStatus == "Pending") {
      return _loans.where((loan) => loan['paymentDate'] == null).toList();
    }
    return _loans; 
  }

  @override
  Widget build(BuildContext context) {
    filteredLoans.sort((a, b) {
      if (a['paymentDate'] == null && b['paymentDate'] != null) {
        return -1; 
      }
      if (a['paymentDate'] != null && b['paymentDate'] == null) {
        return 1; 
      }
      return a['paid'] ? 1 : -1; 
    });

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
                  'Manage Loans',
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
      body: Column(
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
                    items: <String>['All', 'Paid', 'Late', 'Pending'].map((String value) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: filteredLoans.length,
                itemBuilder: (context, index) {
                  final loan = filteredLoans[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), 
                    ),
                    elevation: 5, 
                    color: Colors.white, 
                    child: ListTile(
                      title: Text(loan['coopName']),
                      subtitle: Text(
                        'Loan Date: ${dateFormat.format(loan['loanDate'])} \nDue Date: ${dateFormat.format(loan['dueDate'])} \nLoan Frequency: ${loan['loanFrequency']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      trailing: loan['paymentDate'] == null
                          ? ElevatedButton(
                              onPressed: () => _pickPaymentDate(context, index),
                              child: const Text('Pick Date', style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green, 
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getLoanStatus(loan),
                                  style: TextStyle(
                                    color: loan['paid'] ? Colors.green : Colors.red,
                                  ),
                                ),
                                Text(
                                  'Payment Date: ${loan['paymentDate'] != null ? dateFormat.format(loan['paymentDate']) : "N/A"}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
