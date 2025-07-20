import 'package:flutter/material.dart';
import 'coop_dashboard_screen.dart';  

class CooperativesScreen extends StatefulWidget {
  @override
  _CooperativesScreenState createState() => _CooperativesScreenState();
}

class _CooperativesScreenState extends State<CooperativesScreen> {
  List<Map<String, String>> cooperatives = [
    {'coop_name': 'SIDC', 'municipality': 'Bauan', 'coop_type': 'Multi', 'status': 'Operating'},
    {'coop_name': 'BMPC', 'municipality': 'Lipa', 'coop_type': 'Agri', 'status': 'Non-Compliant'},
    {'coop_name': 'BCSMTSC', 'municipality': 'Rosario', 'coop_type': 'Credit', 'status': 'SCO'},
    {'coop_name': 'BADACO', 'municipality': 'San Jose', 'coop_type': 'Consumer', 'status': 'Operating'},
    {'coop_name': 'BMC', 'municipality': 'San Juan', 'coop_type': 'Multi', 'status': 'Non-Compliant'},
    {'coop_name': 'BTHSMPC', 'municipality': 'Bauan', 'coop_type': 'Agri', 'status': 'Operating'},
    {'coop_name': 'SIDC', 'municipality': 'Lipa', 'coop_type': 'Credit', 'status': 'Operating'},
    {'coop_name': 'LIMCOMA', 'municipality': 'Rosario', 'coop_type': 'Consumer', 'status': 'SCO'},
    {'coop_name': 'PGPMC', 'municipality': 'San Jose', 'coop_type': 'Multi', 'status': 'Operating'},
    {'coop_name': 'TCCOOP', 'municipality': 'San Juan', 'coop_type': 'Agri', 'status': 'Non-Compliant'},
  ];

  TextEditingController _searchController = TextEditingController();
  String? _selectedStatus;
  String? _selectedType;
  String? _selectedMunicipality;

  List<Map<String, String>> filteredCooperatives = [];

  @override
  void initState() {
    super.initState();
    filteredCooperatives = cooperatives;
    _searchController.addListener(_filterCooperatives);
  }

  void _filterCooperatives() {
    setState(() {
      filteredCooperatives = cooperatives.where((coop) {
        bool matchesSearch = coop['coop_name']!
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()) ||
            coop['municipality']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());

        bool matchesStatus = _selectedStatus == null || _selectedStatus == 'All' || coop['status'] == _selectedStatus;

        bool matchesType = _selectedType == null || _selectedType == 'All' || coop['coop_type'] == _selectedType;

        bool matchesMunicipality = _selectedMunicipality == null || _selectedMunicipality == 'All' || coop['municipality'] == _selectedMunicipality;

        return matchesSearch && matchesStatus && matchesType && matchesMunicipality;
      }).toList();
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Operating':
        return Colors.green;
      case 'Non-Compliant':
        return Colors.orange;
      case 'SCO':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _openCoopDashboard(Map<String, String> coopData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoopDashboardScreen(coopData: coopData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), 
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  width: double.infinity, 
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(12), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3), 
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), 
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Cooperatives',
                      labelStyle: TextStyle(color: Colors.black), 
                      border: InputBorder.none,  
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedStatus,
                        hint: Text("Status"),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedStatus = newValue;
                            _filterCooperatives();
                          });
                        },
                        items: ['All', 'Operating', 'Non-Compliant', 'SCO']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, 
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedType,
                        hint: Text("Type"),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedType = newValue;
                            _filterCooperatives();
                          });
                        },
                        items: ['All', 'Multi', 'Agri', 'Credit', 'Consumer']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, 
                        borderRadius: BorderRadius.circular(8),  
                      ),
                      child: DropdownButton<String>(
                        value: _selectedMunicipality,
                        hint: Text("Municipality"),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedMunicipality = newValue;
                            _filterCooperatives();
                          });
                        },
                        items: ['All', 'Bauan', 'Lipa', 'Rosario', 'San Jose', 'San Juan']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  width: double.infinity, 
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DataTable(
                    showCheckboxColumn: false, 
                    columnSpacing: 20,
                    dataRowHeight: 60,
                    headingRowHeight: 60,
                    columns: [
                      DataColumn(
                        label: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Name', // Table header Name
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Municipality', 
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Type', 
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Status', 
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                    rows: filteredCooperatives
                        .map((coop) => DataRow(
                              cells: [
                                DataCell(Text(coop['coop_name']!)),
                                DataCell(Text(coop['municipality']!)),
                                DataCell(Text(coop['coop_type']!)),
                                DataCell(
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(coop['status']!),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      coop['status']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onSelectChanged: (_) {
                                _openCoopDashboard(coop); 
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}