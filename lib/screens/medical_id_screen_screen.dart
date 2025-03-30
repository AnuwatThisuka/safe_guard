import 'package:flutter/material.dart';

class MedicalIDScreen extends StatefulWidget {
  const MedicalIDScreen({super.key});

  @override
  State<MedicalIDScreen> createState() => _MedicalIDScreenState();
}

class _MedicalIDScreenState extends State<MedicalIDScreen> {
  final _formKey = GlobalKey<FormState>();

  String _bloodType = 'A+';
  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  // Form controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _primaryContactNameController = TextEditingController();
  final _primaryContactPhoneController = TextEditingController();
  final _secondaryContactNameController = TextEditingController();
  final _secondaryContactPhoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _conditionsController.dispose();
    _allergiesController.dispose();
    _medicationsController.dispose();
    _primaryContactNameController.dispose();
    _primaryContactPhoneController.dispose();
    _secondaryContactNameController.dispose();
    _secondaryContactPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลทางการแพทย์'),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.save),
            label: const Text('บันทึก'),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Profile Image Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      // TODO: Implement image upload
                    },
                    child: const Text('อัปโหลดรูปภาพ'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Personal Information Section
            _buildSectionHeader(theme, 'ข้อมูลส่วนตัว', Icons.person),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'ชื่อ-นามสกุล',
                        prefixIcon: Icon(Icons.badge),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                              labelText: 'อายุ',
                              prefixIcon: Icon(Icons.cake),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: _bloodType,
                            decoration: const InputDecoration(
                              labelText: 'กรุ๊ปเลือด',
                              prefixIcon: Icon(Icons.bloodtype),
                            ),
                            items: _bloodTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _bloodType = newValue;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Medical Conditions Section
            _buildSectionHeader(
                theme, 'ข้อมูลทางการแพทย์', Icons.medical_services),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _conditionsController,
                      decoration: const InputDecoration(
                        labelText: 'โรคประจำตัว',
                        hintText: 'เช่น เบาหวาน, ความดันโลหิตสูง',
                        prefixIcon: Icon(Icons.medical_information),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _allergiesController,
                      decoration: const InputDecoration(
                        labelText: 'ข้อมูลการแพ้',
                        hintText: 'เช่น แพ้ยา, แพ้อาหาร',
                        prefixIcon: Icon(Icons.coronavirus),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _medicationsController,
                      decoration: const InputDecoration(
                        labelText: 'ยาที่ใช้ประจำ',
                        hintText: 'เช่น ยาลดความดัน, ยาเบาหวาน',
                        prefixIcon: Icon(Icons.medication),
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),

            // Emergency Contacts Section
            _buildSectionHeader(theme, 'ผู้ติดต่อฉุกเฉิน', Icons.contacts),
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildEmergencyContactField(
                        'ผู้ติดต่อหลัก',
                        _primaryContactNameController,
                        _primaryContactPhoneController,
                        theme.colorScheme.primary),
                    const Divider(height: 32),
                    _buildEmergencyContactField(
                        'ผู้ติดต่อสำรอง',
                        _secondaryContactNameController,
                        _secondaryContactPhoneController,
                        theme.colorScheme.secondary),
                  ],
                ),
              ),
            ),

            // Add some space at the bottom for better scrolling experience
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const Expanded(child: SizedBox()),
          Icon(Icons.arrow_right, color: theme.colorScheme.primary),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactField(
      String title,
      TextEditingController nameController,
      TextEditingController phoneController,
      Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person_pin_circle, color: accentColor, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'ชื่อ',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: 'เบอร์โทรศัพท์',
            prefixIcon: const Icon(Icons.phone),
            suffixIcon: IconButton(
              icon: const Icon(Icons.phone_in_talk),
              onPressed: () {
                // TODO: Implement quick call function
                final phoneNumber = phoneController.text;
                if (phoneNumber.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('กำลังโทรไปที่: $phoneNumber')),
                  );
                }
              },
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement save functionality with shared preferences or database
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('บันทึกข้อมูลทางการแพทย์เรียบร้อย'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
