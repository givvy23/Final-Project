import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CoopDashboardScreen extends StatefulWidget {
  final Map<String, String> coopData;

  CoopDashboardScreen({required this.coopData});

  @override
  _CoopDashboardScreenState createState() => _CoopDashboardScreenState();
}

class _CoopDashboardScreenState extends State<CoopDashboardScreen> {
  List<Map<String, dynamic>> assets = [
    {'year': 2021, 'amount': 1000000},
    {'year': 2022, 'amount': 1500000},
    {'year': 2023, 'amount': 1000000},
    {'year': 2024, 'amount': 3000000},
    {'year': 2025, 'amount': 2500000},
  ];

  List<Map<String, dynamic>> members = [
    {'year': 2021, 'count': 500},
    {'year': 2022, 'count': 1000},
    {'year': 2023, 'count': 1500},
    {'year': 2024, 'count': 2000},
  ];

  TextEditingController yearController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String _randomizeLoanFrequency() {
    List<String> frequencies = ['Quarterly', 'Monthly', 'Biannual', 'Annually'];
    Random random = Random();
    return frequencies[random.nextInt(frequencies.length)];
  }

  void _addAsset() {
    setState(() {
      int year = int.parse(yearController.text);
      double amount = double.parse(amountController.text);

      assets.add({'year': year, 'amount': amount});
      yearController.clear();
      amountController.clear();
    });
  }

  String _generateRecommendations() {
    List<String> recommendations = [
      '• The cooperative should improve loan repayment rates by offering better payment terms.',
      '• Focus on enhancing member engagement and offering more financial literacy programs.',
      '• A more aggressive savings campaign could benefit the cooperative’s financial growth.',
      '• Work on creating a sustainable plan to increase assets by attracting more investments.',
      '• Consider offering seminars and training sessions to improve cooperative management and finances.',
      '• Collaborate with other cooperatives to share resources and expand the network.',
      '• Provide support for coop leaders by organizing leadership development workshops.',
    ];

    Random random = Random();
    String reco = recommendations[random.nextInt(recommendations.length)];

    return reco;
  }

  void _exportToPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Cooperative Report'), 
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Exporting Cooperative Report to PDF...'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // Randomize loan frequency
    widget.coopData['loan_frequency'] = _randomizeLoanFrequency();

    bool isLatePayer = widget.coopData['status'] == 'Late';
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), 
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0), 
            bottomRight: Radius.circular(30.0),
          ),
          child: AppBar(
            title: Center(child: Text("PCLEDO", style: TextStyle(color: Colors.white))),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0B6B3C), Color(0xFF002137)], 
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFF5F5F5), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.coopData['coop_name']!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.download, size: 30),
                    onPressed: _exportToPDF, // Trigger PDF export
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Details',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Municipality: ${widget.coopData['municipality']}'),
                    Text('Type: ${widget.coopData['coop_type']}'),
                    Text('Status: ${widget.coopData['status']}'),
                    Text('Loan Frequency: ${widget.coopData['loan_frequency']}'),
                    Text('Late Payer: ${isLatePayer ? "Yes" : "No"}'),
                    SizedBox(height: 20),

                    Text(
                      'Assets Per Year (Editable)',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: assets.map((asset) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Year: ${asset['year']}'),
                              Text('Amount: ₱${asset['amount']}'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: yearController,
                            decoration: InputDecoration(
                              labelText: 'Year',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            decoration: InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _addAsset,
                      child: Text('Add Asset'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                        backgroundColor: Colors.green, 
                        foregroundColor: Colors.white, 
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),

              // KPI Cards Section (Responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildKpiCard('Number of Members', '1,500', Icons.people)),
                        SizedBox(width: 16),
                        Expanded(child: _buildKpiCard('Number of Beneficiaries', '10,000', Icons.group)),
                        SizedBox(width: 16),
                        Expanded(child: _buildKpiCard('Total Assets', '₱4,000,000', Icons.attach_money)),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildKpiCard('Number of Members', '1,500', Icons.people),
                        _buildKpiCard('Number of Beneficiaries', '10,000', Icons.group),
                        _buildKpiCard('Total Assets', '₱4,000,000', Icons.attach_money),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20),

              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildAssetProgressChart()),
                        SizedBox(width: 16),
                        Expanded(child: _buildMemberProgressChart()),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildAssetProgressChart(),
                        SizedBox(height: 16),
                        _buildMemberProgressChart(),
                      ],
                    );
                  }
                },
              ),

              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  'Recommendation: ${_generateRecommendations()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // KPI Card Widget
  Widget _buildKpiCard(String title, String value, IconData icon) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFF1B5E20),
      child: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Asset Progress Over the Years (Line chart)
  Widget _buildAssetProgressChart() {
    return SizedBox(
      height: 250,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,  
          borderRadius: BorderRadius.circular(12),  
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),  
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), 
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Asset Progress Over the Years', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), 
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),  
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true, 
                        reservedSize: 32, 
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('0');
                            case 1000000:
                              return Text('1M');
                            case 2000000:
                              return Text('2M');
                            case 3000000:
                              return Text('3M');
                            case 4000000:
                              return Text('4M');
                            case 5000000:
                              return Text('5M');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, 
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, 
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32, 
                        interval: 1, 
                        getTitlesWidget: (value, meta) {
                          if (value == 0) {
                            return Text('2021');
                          } else if (value == 1) {
                            return Text('2022');
                          } else if (value == 2) {
                            return Text('2023');
                          } else if (value == 3) {
                            return Text('2024');
                          } else if (value == 4) {
                            return Text('2025');
                          }
                          return Container(); 
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: assets.map((asset) {
                        return FlSpot(asset['year'].toDouble() - 2021, asset['amount'].toDouble());
                      }).toList(),
                      isCurved: true,
                      color: Colors.green, 
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Member Progress Over the Years (Line chart)
  Widget _buildMemberProgressChart() {
    return SizedBox(
      height: 250, 
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,  
          borderRadius: BorderRadius.circular(12),  
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), 
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), 
            ),
          ],
        ),
        padding: EdgeInsets.all(16), 
        child: Column(
          children: [
            Text(
              'Yearly Member Progress', 
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),  
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true, 
                        reservedSize: 32, 
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('0');
                            case 500:
                              return Text('500');
                            case 1000:
                              return Text('1k');
                            case 1500:
                              return Text('1.5k');
                            case 2000:
                              return Text('2k');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, 
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false, 
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32, 
                        interval: 1, 
                        getTitlesWidget: (value, meta) {
                          if (value == 0) {
                            return Text('2021');
                          } else if (value == 1) {
                            return Text('2022');
                          } else if (value == 2) {
                            return Text('2023');
                          } else if (value == 3) {
                            return Text('2024');
                          } else if (value == 4) {
                            return Text('2025');
                          }
                          return Container(); 
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: members.map((member) {
                        return FlSpot(member['year'].toDouble() - 2021, member['count'].toDouble());
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue, 
                      barWidth: 4,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
