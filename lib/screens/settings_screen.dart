import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _emergencyCalls = true;
  bool _locationSharing = true;
  bool _darkMode = false;
  String _language = 'ไทย';

  // Selected notification types
  final Set<String> _selectedNotificationTypes = {'emergencies', 'alerts'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การตั้งค่า',
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile section
                  _buildProfileSection(theme),

                  const SizedBox(height: 24),

                  // Settings categories
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'บัญชีผู้ใช้',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildAccountSettings(theme),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'การเข้าถึงและความเป็นส่วนตัว',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPrivacySection(theme),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'การแจ้งเตือน',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildNotificationSection(theme),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'การแสดงผลและภาษา',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildAppearanceSection(theme),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'เกี่ยวกับ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildAboutSection(theme),

                  const SizedBox(height: 40),
                  // Sign out section
                  _buildSignOutSection(theme),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      color: theme.colorScheme.primary,
                      size: 40,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'วิชัย สุขสบาย',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('wichai@email.com'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'สถานะปลอดภัย',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              // Navigate to profile edit screen
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
              side:
                  BorderSide(color: theme.colorScheme.primary.withOpacity(0.5)),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, size: 18),
                const SizedBox(width: 8),
                const Text('แก้ไขโปรไฟล์'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings(ThemeData theme) {
    return _buildCard(
      [
        ListTile(
          leading: _buildIconBadge(Icons.person, theme.colorScheme.primary),
          title: const Text('ข้อมูลบัญชี'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: _buildIconBadge(Icons.shield, theme.colorScheme.tertiary),
          title: const Text('รหัสผ่านและความปลอดภัย'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: _buildIconBadge(Icons.verified_user, Colors.green),
          title: const Text('ยืนยันตัวตน'),
          subtitle: const Text('ยืนยันบัญชีของคุณเพื่อความปลอดภัยเพิ่มเติม'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'ยืนยันแล้ว',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildPrivacySection(ThemeData theme) {
    return _buildCard(
      [
        SwitchListTile(
          secondary:
              _buildIconBadge(Icons.location_on, theme.colorScheme.secondary),
          title: const Text('แชร์ตำแหน่งที่อยู่'),
          subtitle: const Text('กับผู้ติดต่อฉุกเฉินเท่านั้น'),
          value: _locationSharing,
          onChanged: (value) {
            setState(() {
              _locationSharing = value;
            });
          },
        ),
        ListTile(
          leading: _buildIconBadge(Icons.contacts, theme.colorScheme.primary),
          title: const Text('ผู้ติดต่อฉุกเฉิน'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: _buildIconBadge(Icons.health_and_safety, Colors.red),
          title: const Text('ข้อมูลทางการแพทย์'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: _buildIconBadge(Icons.remove_circle_outline, Colors.orange),
          title: const Text('ลบข้อมูล'),
          subtitle: const Text('ลบข้อมูลผู้ใช้และประวัติการใช้งาน'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildNotificationSection(ThemeData theme) {
    return _buildCard(
      [
        SwitchListTile(
          secondary: _buildIconBadge(
              Icons.notifications_active, theme.colorScheme.error),
          title: const Text('การแจ้งเตือนฉุกเฉิน'),
          subtitle: const Text('รับการแจ้งเตือนเกี่ยวกับสถานการณ์ฉุกเฉิน'),
          value: _notifications,
          onChanged: (value) {
            setState(() {
              _notifications = value;
            });
          },
        ),
        SwitchListTile(
          secondary: _buildIconBadge(Icons.call, Colors.blue),
          title: const Text('การโทรฉุกเฉิน'),
          subtitle: const Text('ได้รับข้อความเสียงสำหรับการโทรฉุกเฉิน'),
          value: _emergencyCalls,
          onChanged: (value) {
            setState(() {
              _emergencyCalls = value;
            });
          },
        ),
        if (_notifications) ...[
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ประเภทการแจ้งเตือน',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildNotificationTypeChip(
                        'emergencies', 'เหตุฉุกเฉิน', theme),
                    _buildNotificationTypeChip('alerts', 'การเตือนภัย', theme),
                    _buildNotificationTypeChip('updates', 'อัปเดตระบบ', theme),
                    _buildNotificationTypeChip(
                        'tips', 'เคล็ดลับความปลอดภัย', theme),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNotificationTypeChip(String id, String label, ThemeData theme) {
    final isSelected = _selectedNotificationTypes.contains(id);

    return FilterChip(
      selected: isSelected,
      label: Text(label),
      checkmarkColor: theme.colorScheme.onPrimary,
      selectedColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected ? theme.colorScheme.onPrimary : null,
        fontWeight: isSelected ? FontWeight.w500 : null,
      ),
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedNotificationTypes.add(id);
          } else {
            _selectedNotificationTypes.remove(id);
          }
        });
      },
    );
  }

  Widget _buildAppearanceSection(ThemeData theme) {
    return _buildCard(
      [
        SwitchListTile(
          secondary: _buildIconBadge(
            _darkMode ? Icons.dark_mode : Icons.light_mode,
            _darkMode ? Colors.indigo : Colors.amber,
          ),
          title: const Text('โหมดกลางคืน'),
          subtitle: const Text('สลับระหว่างธีมสว่างและมืด'),
          value: _darkMode,
          onChanged: (value) {
            setState(() {
              _darkMode = value;
            });
          },
        ),
        ListTile(
          leading: _buildIconBadge(Icons.language, Colors.teal),
          title: const Text('ภาษา'),
          subtitle: Text(_language),
          trailing: DropdownButton<String>(
            value: _language,
            isDense: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _language = newValue;
                });
              }
            },
            items: ['ไทย', 'English', '中文', '日本語']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        ListTile(
          leading: _buildIconBadge(Icons.text_fields, Colors.purple),
          title: const Text('ขนาดตัวอักษร'),
          trailing: CupertinoSegmentedControl(
            padding: const EdgeInsets.symmetric(vertical: 8),
            groupValue: 1,
            children: const {
              0: Text("เล็ก", style: TextStyle(fontSize: 12)),
              1: Text("กลาง", style: TextStyle(fontSize: 14)),
              2: Text("ใหญ่", style: TextStyle(fontSize: 16)),
            },
            onValueChanged: (int value) {
              // Set font size
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(ThemeData theme) {
    return _buildCard(
      [
        ListTile(
          leading:
              _buildIconBadge(Icons.system_update, theme.colorScheme.primary),
          title: const Text('เวอร์ชั่นแอปพลิเคชัน'),
          subtitle: const Text('1.0.0'),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'ล่าสุด',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        ListTile(
          leading: _buildIconBadge(Icons.star, Colors.amber),
          title: const Text('ให้คะแนนแอปพลิเคชัน'),
          subtitle: const Text('ช่วยเราพัฒนาแอปให้ดีขึ้น'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: _buildIconBadge(Icons.help_outline, Colors.blue),
          title: const Text('ช่วยเหลือ'),
          subtitle: const Text('ศูนย์ช่วยเหลือและคำถามที่พบบ่อย'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ExpansionTile(
          leading: _buildIconBadge(Icons.description, Colors.grey),
          title: const Text('ข้อกำหนดและนโยบาย'),
          children: [
            ListTile(
              leading: const SizedBox(width: 24),
              title: const Text('เงื่อนไขการใช้งาน'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const SizedBox(width: 24),
              title: const Text('นโยบายความเป็นส่วนตัว'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              leading: const SizedBox(width: 24),
              title: const Text('นโยบายคุกกี้'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignOutSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          FilledButton.icon(
            onPressed: () => _showSignOutDialog(),
            icon: const Icon(Icons.logout),
            label: const Text('ออกจากระบบ'),
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'SafeGuard v1.0.0 - รักษาความปลอดภัยของคุณเสมอ',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildIconBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ออกจากระบบ'),
          content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ยกเลิก'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implement actual sign out logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ออกจากระบบเรียบร้อยแล้ว')),
                );
              },
              child: const Text('ออกจากระบบ'),
            ),
          ],
        );
      },
    );
  }
}
