import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),  
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),  

              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildKpiCard('Number of Cooperatives', '365', Icons.apartment)),
                        SizedBox(width: 16),
                        Expanded(child: _buildKpiCard('Number of Members', '10,000', Icons.people)),
                        SizedBox(width: 16),
                        Expanded(child: _buildKpiCard('Assets', '₱50,000,000', Icons.attach_money)),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildKpiCard('Number of Cooperatives', '365', Icons.apartment),
                        _buildKpiCard('Number of Members', '10,000', Icons.people),
                        _buildKpiCard('Assets', '₱50,000,000', Icons.attach_money),
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
                        Expanded(child: _buildBarChart()),
                        SizedBox(width: 16),
                        Expanded(child: _buildPieChart()),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildBarChart(),
                        SizedBox(height: 16),
                        _buildPieChart(),
                      ],
                    );
                  }
                },
              ),

              SizedBox(height: 30),

              // Line Chart Section
              _buildLineChart(),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildBarChart() {
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
        padding: EdgeInsets.all(8), 
        child: Column(
          children: [
            Text(
              'Types of Cooperatives by Municipality',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegend('Credit', Colors.blue),
                  _buildLegend('Multi', Colors.green),
                  _buildLegend('Agri', Colors.red),
                  _buildLegend('Consumer', Colors.orange),
                ],
              ),
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: true), 
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), 
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false), 
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('0');
                            case 10:
                              return Text('10');
                            case 20:
                              return Text('20');
                            case 30:
                              return Text('30');
                            case 40:
                              return Text('40');
                            case 50:
                              return Text('50');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text('Bauan');
                            case 1:
                              return Text('Lipa');
                            case 2:
                              return Text('Rosario');
                            default:
                              return Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(toY: 35, color: Colors.blue, width: 20),
                      BarChartRodData(toY: 40, color: Colors.green, width: 20),
                      BarChartRodData(toY: 50, color: Colors.red, width: 20),
                      BarChartRodData(toY: 45, color: Colors.orange, width: 20),
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 30, color: Colors.blue, width: 20),
                      BarChartRodData(toY: 35, color: Colors.green, width: 20),
                      BarChartRodData(toY: 40, color: Colors.red, width: 20),
                      BarChartRodData(toY: 45, color: Colors.orange, width: 20),
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 25, color: Colors.blue, width: 20),
                      BarChartRodData(toY: 30, color: Colors.green, width: 20),
                      BarChartRodData(toY: 35, color: Colors.red, width: 20),
                      BarChartRodData(toY: 40, color: Colors.orange, width: 20),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(String type, Color color) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        SizedBox(width: 8),
        Text(type),
        SizedBox(width: 16),
      ],
    );
  }

  // Pie chart widget
  Widget _buildPieChart() {
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
              'Cooperative Operational Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), 
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 180, title: '180', radius: 30, color: Colors.green),
                    PieChartSectionData(value: 120, title: '120', radius: 30, color: Colors.orange),
                    PieChartSectionData(value: 65, title: '65', radius: 30, color: Colors.red),
                  ],
                  centerSpaceRadius: 40,
                  sectionsSpace: 4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegend('Operating', Colors.green),
                  _buildLegend('Non-Compliant', Colors.orange),
                  _buildLegend('SCO', Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
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
                            case 2000:
                              return Text('2k');
                            case 4000:
                              return Text('4k');
                            case 6000:
                              return Text('6k');
                            case 8000:
                              return Text('8k');
                            case 10000:
                              return Text('10k');
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
                      spots: [
                        FlSpot(0, 500),
                        FlSpot(1, 1000),
                        FlSpot(2, 2000),
                        FlSpot(3, 4000),
                        FlSpot(4, 6000),
                      ],
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
}
