import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _sosAnimationController;
  bool _sosPressed = false;
  Timer? _sosTimer;
  int _sosCountdown = 3;

  @override
  void initState() {
    super.initState();
    _sosAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _sosAnimationController.dispose();
    _sosTimer?.cancel();
    super.dispose();
  }

  void _startSOSCountdown() {
    setState(() {
      _sosPressed = true;
      _sosCountdown = 3;
    });

    _sosTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_sosCountdown > 1) {
          _sosCountdown--;
        } else {
          _triggerSOS();
          timer.cancel();
        }
      });
    });
  }

  void _cancelSOSCountdown() {
    setState(() {
      _sosPressed = false;
    });
    _sosTimer?.cancel();
  }

  void _triggerSOS() {
    setState(() {
      _sosPressed = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white),
            const SizedBox(width: 12),
            const Expanded(
                child: Text('กำลังส่งสัญญาณ SOS และแจ้งตำแหน่งของคุณ')),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'ยกเลิก',
          textColor: Colors.white,
          onPressed: () {
            // Cancel SOS
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDark = theme.brightness == Brightness.dark;

    final primaryColor =
        isDark ? const Color(0xFF4285F4) : const Color(0xFF1A73E8);
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtleTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'ช่วยเหลือฉุกเฉิน',
        ),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
            tooltip: 'การตั้งค่า',
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User status card
                    Card(
                      elevation: 0,
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isDark ? Colors.white12 : Colors.black12,
                          width: 0.5,
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 8, bottom: 24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: primaryColor.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                size: 28,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'สวัสดี, คุณวิชัย',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
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
                                        'ปลอดภัย • ติดตามตำแหน่ง',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.shield_outlined,
                                color: primaryColor,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // SOS Button
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _sosAnimationController,
                            builder: (context, child) {
                              return Container(
                                width: size.width * 0.56,
                                height: size.width * 0.56,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _sosPressed
                                      ? theme.colorScheme.error
                                          .withOpacity(0.08)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: _sosPressed
                                        ? theme.colorScheme.error.withOpacity(
                                            0.2 +
                                                0.3 *
                                                    _sosAnimationController
                                                        .value)
                                        : Colors.transparent,
                                    width: 3,
                                  ),
                                ),
                                child: Center(child: child),
                              );
                            },
                            child: GestureDetector(
                              onLongPressStart: (_) => _startSOSCountdown(),
                              onLongPressEnd: (_) => _cancelSOSCountdown(),
                              child: Container(
                                width: size.width * 0.48,
                                height: size.width * 0.48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const RadialGradient(
                                    colors: [
                                      Color(0xFFEF4444),
                                      Color(0xFFDC2626),
                                    ],
                                    center: Alignment.center,
                                    radius: 0.8,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFEF4444)
                                          .withOpacity(0.3),
                                      blurRadius: _sosPressed ? 20 : 12,
                                      spreadRadius: _sosPressed ? 2 : 0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      _sosPressed ? '$_sosCountdown' : 'SOS',
                                      style: TextStyle(
                                        fontSize: _sosPressed ? 36 : 42,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      _sosPressed ? 'กรุณารอ...' : 'กดค้างไว้',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'กดปุ่ม SOS ค้างไว้เพื่อส่งสัญญาณขอความช่วยเหลือฉุกเฉิน',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: subtleTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Quick Actions - "Help me now" section
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ต้องการความช่วยเหลือทันที',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildQuickActionButton(
                                  context,
                                  'แชร์ตำแหน่ง',
                                  Icons.share_location,
                                  primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildQuickActionButton(
                                  context,
                                  'แจ้งเตือนอันตราย',
                                  Icons.warning_amber_rounded,
                                  theme.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Emergency services grid section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.phone_enabled_rounded,
                              size: 20,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'บริการฉุกเฉิน',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Emergency Services Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final services = [
                      {
                        'number': '191',
                        'name': 'ตำรวจ',
                        'icon': Icons.local_police,
                        'color': primaryColor,
                      },
                      {
                        'number': '1669',
                        'name': 'รถพยาบาล',
                        'icon': Icons.medical_services,
                        'color': const Color(0xFF4CAF50),
                      },
                      {
                        'number': '199',
                        'name': 'ดับเพลิง',
                        'icon': Icons.local_fire_department,
                        'color': const Color(0xFFF44336),
                      },
                      {
                        'number': '1155',
                        'name': 'ทางหลวง',
                        'icon': Icons.directions_car,
                        'color': const Color(0xFF607D8B),
                      },
                      {
                        'number': '1784',
                        'name': 'กู้ภัย',
                        'icon': Icons.healing,
                        'color': const Color(0xFF009688),
                      },
                      {
                        'number': '1646',
                        'name': 'การไฟฟ้า',
                        'icon': Icons.electrical_services,
                        'color': const Color(0xFFFFC107),
                      },
                    ];

                    final service = services[index];

                    return _buildEmergencyService(
                      context,
                      service['number'] as String,
                      service['name'] as String,
                      service['icon'] as IconData,
                      service['color'] as Color,
                      isDark,
                      cardColor,
                      textColor,
                      subtleTextColor,
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),

            // Safety Resources Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'แหล่งข้อมูลด้านความปลอดภัย',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Safety Resources Horizontal Scroll
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSafetyResource(
                      context,
                      'การปฐมพยาบาล',
                      Icons.medical_information,
                      const Color(0xFF4CAF50),
                      isDark,
                    ),
                    _buildSafetyResource(
                      context,
                      'สถานที่ปลอดภัย',
                      Icons.location_on,
                      primaryColor,
                      isDark,
                    ),
                    _buildSafetyResource(
                      context,
                      'ขอความช่วยเหลือ',
                      Icons.support_agent,
                      const Color(0xFFFF9800),
                      isDark,
                    ),
                    _buildSafetyResource(
                      context,
                      'แผนอพยพ',
                      Icons.crisis_alert,
                      const Color(0xFF9C27B0),
                      isDark,
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('กำลัง$label...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyService(
    BuildContext context,
    String number,
    String label,
    IconData icon,
    Color color,
    bool isDark,
    Color cardColor,
    Color textColor,
    Color subtleTextColor,
  ) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? Colors.white12 : Colors.black12,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.call, color: Colors.white),
                  const SizedBox(width: 12),
                  Text('กำลังโทรหา $label ($number)...'),
                ],
              ),
              backgroundColor: color,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              number,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: subtleTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyResource(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
