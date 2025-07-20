import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/cooperative_profile.dart';
import 'boardmember.dart';

class BasicInformationScreen extends StatefulWidget {
  final String username;
  final String password;
  final String email;

  const BasicInformationScreen({
    Key? key,
    required this.username,
    required this.password,
    required this.email,
  }) : super(key: key);

  @override
  State<BasicInformationScreen> createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each field
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _districtController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _authorizedRepController = TextEditingController();
  final _designationController = TextEditingController();
  final _cinController = TextEditingController();
  final _registrationNoController = TextEditingController();
  final _registrationDateController = TextEditingController();
  final _generalAssemblyDateController = TextEditingController();
  final _quorumRequirementController = TextEditingController();
  final _coopTypeController = TextEditingController();
  final _areaOfOperationController = TextEditingController();
  final _bondOfMembershipController = TextEditingController();
  final _businessActivitiesController = TextEditingController();
  final _additionalBusinessController = TextEditingController();
  final _includedInPurposeController = TextEditingController();
  final _otherFinancialServicesController = TextEditingController();
  final _productsCommoditiesController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _districtController.dispose();
    _telephoneController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _authorizedRepController.dispose();
    _designationController.dispose();
    _cinController.dispose();
    _registrationNoController.dispose();
    _registrationDateController.dispose();
    _generalAssemblyDateController.dispose();
    _quorumRequirementController.dispose();
    _coopTypeController.dispose();
    _areaOfOperationController.dispose();
    _bondOfMembershipController.dispose();
    _businessActivitiesController.dispose();
    _additionalBusinessController.dispose();
    _includedInPurposeController.dispose();
    _otherFinancialServicesController.dispose();
    _productsCommoditiesController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile(CooperativeProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'user_${widget.username}',
      jsonEncode({'password': widget.password, 'profile': profile.toJson()}),
    );
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  void _next() async {
    if (_formKey.currentState!.validate()) {
      final profile = CooperativeProfile(
        nameOfCoop: _nameController.text,
        address: _addressController.text,
        congressionalDistrict: _districtController.text,
        telephoneNo: _telephoneController.text,
        mobileNo: _mobileController.text,
        emailAddress: widget.email, // Use the email from sign up
        authorizedRep: _authorizedRepController.text,
        designation: _designationController.text,
        cin: _cinController.text,
        registrationNo: _registrationNoController.text,
        registrationDate: _registrationDateController.text,
        generalAssemblyDate: _generalAssemblyDateController.text,
        quorumRequirement: _quorumRequirementController.text,
        coopType: _coopTypeController.text,
        areaOfOperation: _areaOfOperationController.text,
        bondOfMembership: _bondOfMembershipController.text,
        businessActivities: _businessActivitiesController.text,
        additionalBusiness: _additionalBusinessController.text,
        includedInPurpose: _includedInPurposeController.text,
        otherFinancialServices: _otherFinancialServicesController.text,
        productsCommodities: _productsCommoditiesController.text,
      );

      await _saveProfile(profile);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BoardFormScreen(
            profile: profile,
            username: widget.username,
            password: widget.password,
          ),
        ),
      );
    }
  }

  Widget _buildRoundedTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
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
                    'Basic Information',
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
                      _buildRoundedTextField(
                        "Name of Cooperative",
                        _nameController,
                      ),
                      _buildRoundedTextField("Address", _addressController),
                      _buildRoundedTextField(
                        "Congressional District",
                        _districtController,
                      ),
                      _buildRoundedTextField(
                        "Telephone No.",
                        _telephoneController,
                      ),
                      _buildRoundedTextField("Mobile No.", _mobileController),
                      _buildRoundedTextField(
                        "Email Address",
                        _emailController..text = widget.email,
                      ),
                      _buildRoundedTextField(
                        "Authorized Representative",
                        _authorizedRepController,
                      ),
                      _buildRoundedTextField(
                        "Designation",
                        _designationController,
                      ),
                      _buildRoundedTextField(
                        "CIN(Cooperative Identification Number)",
                        _cinController,
                      ),
                      _buildRoundedTextField(
                        "Registration No.",
                        _registrationNoController,
                      ),
                      _buildRoundedTextField(
                        "Registration Date",
                        _registrationDateController,
                        readOnly: true,
                        onTap: () =>
                            _pickDate(context, _registrationDateController),
                      ),
                      _buildRoundedTextField(
                        "Date Of General Assembly",
                        _generalAssemblyDateController,
                        readOnly: true,
                        onTap: () =>
                            _pickDate(context, _generalAssemblyDateController),
                      ),
                      _buildRoundedTextField(
                        "Quorom Requirement",
                        _quorumRequirementController,
                      ),
                      DropdownButtonFormField<String>(
                        value: _coopTypeController.text.isNotEmpty
                            ? _coopTypeController.text
                            : null,
                        decoration: InputDecoration(
                          labelText: "Type Of Cooperative",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Operating",
                            child: Text("Operating"),
                          ),
                          DropdownMenuItem(
                            value: "Non Operating",
                            child: Text("Non Operating"),
                          ),
                          DropdownMenuItem(value: "SCO", child: Text("SCO")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _coopTypeController.text = value ?? '';
                          });
                        },
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Required'
                            : null,
                      ),
                      _buildRoundedTextField(
                        "Area of Operation",
                        _areaOfOperationController,
                      ),
                      _buildRoundedTextField(
                        "Bond of Membership",
                        _bondOfMembershipController,
                      ),
                      _buildRoundedTextField(
                        "Business Activities",
                        _businessActivitiesController,
                      ),
                      _buildRoundedTextField(
                        "Additional/New Business for this year",
                        _additionalBusinessController,
                      ),
                      _buildRoundedTextField(
                        "Is it included on Purpose & Objective in your Articles of Coop?",
                        _includedInPurposeController,
                      ),
                      _buildRoundedTextField(
                        "Other Financial Services",
                        _otherFinancialServicesController,
                      ),
                      _buildRoundedTextField(
                        "Product/Commodities:(if any)",
                        _productsCommoditiesController,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _next,
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
