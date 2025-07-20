import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/cooperative_profile.dart';
import 'profile.dart';

class BoardFormScreen extends StatefulWidget {
  final CooperativeProfile profile;
  final String username;
  final String password;
  const BoardFormScreen({
    Key? key,
    required this.profile,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  State<BoardFormScreen> createState() => _BoardFormScreenState();
}

class _BoardFormScreenState extends State<BoardFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final _numBoardDirectorsController = TextEditingController();
  final _numMaleBoardDirectorsController = TextEditingController();
  final _numFemaleBoardDirectorsController = TextEditingController();
  final _numPartTimeEmployeesController = TextEditingController();
  final _numFullTimeEmployeesController = TextEditingController();
  final _numMaleEmployeesController = TextEditingController();
  final _numFemaleEmployeesController = TextEditingController();
  final _numSalariedEmployeesController = TextEditingController();
  final _numEmployeesWithAllowancesController = TextEditingController();
  final _employeesSSSController = TextEditingController();
  final _employeesPhilhealthController = TextEditingController();
  final _employeesPagIbigController = TextEditingController();
  final _reserveFundController = TextEditingController();
  final _fundPayableController = TextEditingController();
  final _numRegularMembersController = TextEditingController();
  final _numAssociateMembersController = TextEditingController();
  final _numMaleRegularMembersController = TextEditingController();
  final _numFemaleRegularMembersController = TextEditingController();
  final _numMaleAssociateMembersController = TextEditingController();
  final _numFemaleAssociateMembersController = TextEditingController();
  final _certificateOfComplianceController = TextEditingController();
  final _validityComplianceController = TextEditingController();
  final _certificateOfTaxExemptionController = TextEditingController();
  final _validityTaxExemptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numBoardDirectorsController.text = widget.profile.numBoardDirectors;
    _numMaleBoardDirectorsController.text =
        widget.profile.numMaleBoardDirectors;
    _numFemaleBoardDirectorsController.text =
        widget.profile.numFemaleBoardDirectors;
    _numPartTimeEmployeesController.text = widget.profile.numPartTimeEmployees;
    _numFullTimeEmployeesController.text = widget.profile.numFullTimeEmployees;
    _numMaleEmployeesController.text = widget.profile.numMaleEmployees;
    _numFemaleEmployeesController.text = widget.profile.numFemaleEmployees;
    _numSalariedEmployeesController.text = widget.profile.numSalariedEmployees;
    _numEmployeesWithAllowancesController.text =
        widget.profile.numEmployeesWithAllowances;
    _employeesSSSController.text = widget.profile.employeesSSS;
    _employeesPhilhealthController.text = widget.profile.employeesPhilhealth;
    _employeesPagIbigController.text = widget.profile.employeesPagIbig;
    _reserveFundController.text = widget.profile.reserveFund;
    _fundPayableController.text = widget.profile.fundPayable;
    _numRegularMembersController.text = widget.profile.numRegularMembers;
    _numAssociateMembersController.text = widget.profile.numAssociateMembers;
    _numMaleRegularMembersController.text =
        widget.profile.numMaleRegularMembers;
    _numFemaleRegularMembersController.text =
        widget.profile.numFemaleRegularMembers;
    _numMaleAssociateMembersController.text =
        widget.profile.numMaleAssociateMembers;
    _numFemaleAssociateMembersController.text =
        widget.profile.numFemaleAssociateMembers;
    _certificateOfComplianceController.text =
        widget.profile.certificateOfCompliance;
    _validityComplianceController.text = widget.profile.validityCompliance;
    _certificateOfTaxExemptionController.text =
        widget.profile.certificateOfTaxExemption;
    _validityTaxExemptionController.text = widget.profile.validityTaxExemption;
  }

  @override
  void dispose() {
    _numBoardDirectorsController.dispose();
    _numMaleBoardDirectorsController.dispose();
    _numFemaleBoardDirectorsController.dispose();
    _numPartTimeEmployeesController.dispose();
    _numFullTimeEmployeesController.dispose();
    _numMaleEmployeesController.dispose();
    _numFemaleEmployeesController.dispose();
    _numSalariedEmployeesController.dispose();
    _numEmployeesWithAllowancesController.dispose();
    _employeesSSSController.dispose();
    _employeesPhilhealthController.dispose();
    _employeesPagIbigController.dispose();
    _reserveFundController.dispose();
    _fundPayableController.dispose();
    _numRegularMembersController.dispose();
    _numAssociateMembersController.dispose();
    _numMaleRegularMembersController.dispose();
    _numFemaleRegularMembersController.dispose();
    _numMaleAssociateMembersController.dispose();
    _numFemaleAssociateMembersController.dispose();
    _certificateOfComplianceController.dispose();
    _validityComplianceController.dispose();
    _certificateOfTaxExemptionController.dispose();
    _validityTaxExemptionController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile(CooperativeProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'user_${widget.username}',
      jsonEncode({'password': widget.password, 'profile': profile.toJson()}),
    );
  }

  void _saveAndNext() async {
    if (_formKey.currentState!.validate()) {
      widget.profile.numBoardDirectors = _numBoardDirectorsController.text;
      widget.profile.numMaleBoardDirectors =
          _numMaleBoardDirectorsController.text;
      widget.profile.numFemaleBoardDirectors =
          _numFemaleBoardDirectorsController.text;
      widget.profile.numPartTimeEmployees =
          _numPartTimeEmployeesController.text;
      widget.profile.numFullTimeEmployees =
          _numFullTimeEmployeesController.text;
      widget.profile.numMaleEmployees = _numMaleEmployeesController.text;
      widget.profile.numFemaleEmployees = _numFemaleEmployeesController.text;
      widget.profile.numSalariedEmployees =
          _numSalariedEmployeesController.text;
      widget.profile.numEmployeesWithAllowances =
          _numEmployeesWithAllowancesController.text;
      widget.profile.employeesSSS = _employeesSSSController.text;
      widget.profile.employeesPhilhealth = _employeesPhilhealthController.text;
      widget.profile.employeesPagIbig = _employeesPagIbigController.text;
      widget.profile.reserveFund = _reserveFundController.text;
      widget.profile.fundPayable = _fundPayableController.text;
      widget.profile.numRegularMembers = _numRegularMembersController.text;
      widget.profile.numAssociateMembers = _numAssociateMembersController.text;
      widget.profile.numMaleRegularMembers =
          _numMaleRegularMembersController.text;
      widget.profile.numFemaleRegularMembers =
          _numFemaleRegularMembersController.text;
      widget.profile.numMaleAssociateMembers =
          _numMaleAssociateMembersController.text;
      widget.profile.numFemaleAssociateMembers =
          _numFemaleAssociateMembersController.text;
      widget.profile.certificateOfCompliance =
          _certificateOfComplianceController.text;
      widget.profile.validityCompliance = _validityComplianceController.text;
      widget.profile.certificateOfTaxExemption =
          _certificateOfTaxExemptionController.text;
      widget.profile.validityTaxExemption =
          _validityTaxExemptionController.text;

      await _saveProfile(widget.profile);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AssetFormScreen(
            profile: widget.profile,
            username: widget.username,
            password: widget.password,
          ),
        ),
      );
    }
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 36,
                left: 24,
                right: 24,
                bottom: 32,
              ),
              decoration: const BoxDecoration(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 10),
                  Text(
                    'Boardof Directors, Members, Employees',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please fill out all required fields.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        "Number of Board of Directors",
                        _numBoardDirectorsController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Male Board of Directors",
                        _numMaleBoardDirectorsController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Female Board of Directors",
                        _numFemaleBoardDirectorsController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Part-time Employees",
                        _numPartTimeEmployeesController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Full-time Employees",
                        _numFullTimeEmployeesController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Male Employees",
                        _numMaleEmployeesController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Female Employees",
                        _numFemaleEmployeesController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Salaried Employees",
                        _numSalariedEmployeesController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Employees with Allowances",
                        _numEmployeesWithAllowancesController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Employees with SSS",
                        _employeesSSSController,
                      ),
                      _buildTextField(
                        "Employees with Philhealth",
                        _employeesPhilhealthController,
                      ),
                      _buildTextField(
                        "Employees with Pag-IBIG",
                        _employeesPagIbigController,
                      ),
                      _buildTextField("Reserve Fund", _reserveFundController),
                      _buildTextField("Fund Payable", _fundPayableController),
                      _buildTextField(
                        "Number of Regular Members",
                        _numRegularMembersController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Associate Members",
                        _numAssociateMembersController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Male Regular Members",
                        _numMaleRegularMembersController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Female Regular Members",
                        _numFemaleRegularMembersController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Male Associate Members",
                        _numMaleAssociateMembersController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Number of Female Associate Members",
                        _numFemaleAssociateMembersController,
                        isNumber: true,
                      ),
                      _buildTextField(
                        "Certificate of Compliance",
                        _certificateOfComplianceController,
                      ),
                      _buildTextField(
                        "Validity of Compliance",
                        _validityComplianceController,
                      ),
                      _buildTextField(
                        "Certificate of Tax Exemption",
                        _certificateOfTaxExemptionController,
                      ),
                      _buildTextField(
                        "Validity of Tax Exemption",
                        _validityTaxExemptionController,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveAndNext,
                          child: const Text(
                            "NEXT",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssetFormScreen extends StatefulWidget {
  final CooperativeProfile profile;
  final String username;
  final String password;
  const AssetFormScreen({
    Key? key,
    required this.profile,
    required this.username,
    required this.password,
  }) : super(key: key);

  @override
  State<AssetFormScreen> createState() => _AssetFormScreenState();
}

class _AssetFormScreenState extends State<AssetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _amountController = TextEditingController();

  List<Map<String, String>> assets = [];

  Future<void> _saveProfile(CooperativeProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'user_${widget.username}',
      jsonEncode({'password': widget.password, 'profile': profile.toJson()}),
    );
  }

  void _addAsset() {
    if (_yearController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        assets.add({
          "year": _yearController.text,
          "amount": _amountController.text,
        });
        _yearController.clear();
        _amountController.clear();
      });
    }
  }

  void _saveAndFinish() async {
    if (assets.isNotEmpty) {
      widget.profile.assets = assets;
      await _saveProfile(widget.profile);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => UserProfileScreen(profile: widget.profile),
        ),
      );
    }
  }

  @override
  void dispose() {
    _yearController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 36,
                left: 24,
                right: 24,
                bottom: 32,
              ),
              decoration: const BoxDecoration(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 10),
                  Text(
                    'Assets',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your assets and amounts below.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _yearController,
                        decoration: InputDecoration(
                          labelText: "Year",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addAsset,
                          child: const Text("Add Asset"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ...assets.map(
                        (asset) => ListTile(
                          title: Text("Year: ${asset["year"]}"),
                          subtitle: Text("Amount: ${asset["amount"]}"),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveAndFinish,
                          child: const Text(
                            "FINISH",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
