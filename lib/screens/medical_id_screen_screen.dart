import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MedicalIDScreen extends StatefulWidget {
  const MedicalIDScreen({super.key});

  @override
  State<MedicalIDScreen> createState() => _MedicalIDScreenState();
}

class _MedicalIDScreenState extends State<MedicalIDScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  bool _isEditing = true; // สถานะสำหรับการแก้ไข/ดู

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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลทางการแพทย์',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: Icon(_isEditing ? Icons.visibility : Icons.edit,
              color: colorScheme.primary),
          onPressed: _toggleEditMode,
          tooltip: _isEditing ? 'ดูข้อมูล' : 'แก้ไขข้อมูล',
        ),
        actions: [
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilledButton.icon(
                icon: const Icon(Icons.save_outlined, size: 18),
                label: const Text('บันทึก'),
                onPressed: _saveForm,
              ),
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surfaceVariant.withOpacity(0.3),
              colorScheme.surface,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildProfileSection(colorScheme),
              const SizedBox(height: 16),

              // Sections
              AnimatedOpacity(
                opacity: _isEditing ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 300),
                child: AbsorbPointer(
                  absorbing: !_isEditing,
                  child: Column(
                    children: [
                      _buildPersonalInfoSection(colorScheme),
                      _buildMedicalInfoSection(colorScheme),
                      _buildEmergencyContactsSection(colorScheme),
                    ],
                  ),
                ),
              ),

              // Bottom space
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(ColorScheme colorScheme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _isEditing ? _pickImage : null,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: _profileImage == null
                          ? colorScheme.primaryContainer
                          : null,
                    ),
                    child: _profileImage == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: colorScheme.onPrimaryContainer,
                          )
                        : null,
                  ),
                  if (_isEditing)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'รูปประจำตัว',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            if (_isEditing)
              Text(
                'แตะที่รูปเพื่ออัปโหลดรูปภาพ',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.outline,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(ColorScheme colorScheme) {
    return _buildSectionCard(
      title: 'ข้อมูลส่วนตัว',
      icon: Icons.person,
      colorScheme: colorScheme,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _nameController,
            label: 'ชื่อ-นามสกุล',
            icon: Icons.badge,
            validator: (value) =>
                value?.isEmpty == true ? 'กรุณากรอกชื่อ' : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildTextField(
                  controller: _ageController,
                  label: 'อายุ',
                  icon: Icons.cake,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: _buildDropdown(
                  value: _bloodType,
                  label: 'กรุ๊ปเลือด',
                  items: _bloodTypes,
                  icon: Icons.bloodtype,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _bloodType = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalInfoSection(ColorScheme colorScheme) {
    return _buildSectionCard(
      title: 'ข้อมูลทางการแพทย์',
      icon: Icons.medical_services,
      colorScheme: colorScheme,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _conditionsController,
            label: 'โรคประจำตัว',
            hint: 'เช่น เบาหวาน, ความดันโลหิตสูง',
            icon: Icons.medical_information,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _allergiesController,
            label: 'ข้อมูลการแพ้',
            hint: 'เช่น แพ้ยา, แพ้อาหาร',
            icon: Icons.coronavirus,
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _medicationsController,
            label: 'ยาที่ใช้ประจำ',
            hint: 'เช่น ยาลดความดัน, ยาเบาหวาน',
            icon: Icons.medication,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContactsSection(ColorScheme colorScheme) {
    return _buildSectionCard(
      title: 'ผู้ติดต่อฉุกเฉิน',
      icon: Icons.contacts,
      colorScheme: colorScheme,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactField(
            title: 'ผู้ติดต่อหลัก',
            nameController: _primaryContactNameController,
            phoneController: _primaryContactPhoneController,
            colorScheme: colorScheme,
            accentColor: colorScheme.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: colorScheme.outlineVariant),
          ),
          _buildContactField(
            title: 'ผู้ติดต่อสำรอง',
            nameController: _secondaryContactNameController,
            phoneController: _secondaryContactPhoneController,
            colorScheme: colorScheme,
            accentColor: colorScheme.tertiary,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget content,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const Spacer(),
              if (!_isEditing)
                Icon(Icons.arrow_forward_ios,
                    size: 14, color: colorScheme.outline),
            ],
          ),
        ),
        Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side:
                BorderSide(color: colorScheme.outlineVariant.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String value,
    required String label,
    required List<String> items,
    required IconData icon,
    required void Function(String?)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      items: items
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildContactField({
    required String title,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required ColorScheme colorScheme,
    required Color accentColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person_pin_circle, color: accentColor, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: accentColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: nameController,
          label: 'ชื่อ',
          icon: Icons.person,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: 'เบอร์โทรศัพท์',
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            suffixIcon: _isEditing
                ? null
                : IconButton(
                    icon: Icon(
                      Icons.phone_in_talk,
                      color: accentColor,
                    ),
                    onPressed: () {
                      final phoneNumber = phoneController.text;
                      if (phoneNumber.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('กำลังโทรไปที่: $phoneNumber')),
                        );
                      }
                    },
                  ),
          ),
          keyboardType: TextInputType.phone,
        ),
        if (!_isEditing)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.phone_enabled, size: 18),
              label: const Text('โทรฉุกเฉิน'),
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onPressed: () {
                final phoneNumber = phoneController.text;
                if (phoneNumber.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('กำลังโทรไปที่: $phoneNumber'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ),
      ],
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // บันทึกข้อมูลด้วย shared preferences หรือฐานข้อมูล

      // แสดง feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('บันทึกข้อมูลทางการแพทย์เรียบร้อยแล้ว'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      );

      // สลับไปยังโหมดดูข้อมูล
      setState(() {
        _isEditing = false;
      });
    }
  }
}
