import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _numPages = 3;

  final List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: 'ยินดีต้อนรับสู่ Safe Guard',
      description:
          'แอปพลิเคชันที่ช่วยคุณจัดการข้อมูลทางการแพทย์และการแจ้งเตือนฉุกเฉินได้อย่างง่ายดาย',
      illustration: 'assets/images/onboarding_1.png',
      color: const Color(0xFF6C63FF),
      iconData: Icons.health_and_safety,
    ),
    OnboardingPageData(
      title: 'จัดการข้อมูลทางการแพทย์',
      description:
          'บันทึกข้อมูลประวัติทางการแพทย์ โรคประจำตัว และผู้ติดต่อฉุกเฉินไว้ในที่เดียว',
      illustration: 'assets/images/onboarding_2.png',
      color: const Color(0xFF4CAF50),
      iconData: Icons.medical_services,
    ),
    OnboardingPageData(
      title: 'ขอความช่วยเหลือได้ทันที',
      description:
          'เพียงกดปุ่ม SOS สามารถส่งข้อความและพิกัดของคุณไปยังผู้ติดต่อฉุกเฉินได้ทันที',
      illustration: 'assets/images/onboarding_3.png',
      color: const Color(0xFFE53935),
      iconData: Icons.emergency,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            // Page View for onboarding slides
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _numPages,
              itemBuilder: (context, index) {
                return OnboardingPage(pageData: _pages[index]);
              },
            ),

            // Bottom navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNavigation(),
            ),

            // Skip button
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 20,
              child: _currentPage < _numPages - 1
                  ? TextButton(
                      onPressed: () {
                        _pageController.animateToPage(
                          _numPages - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: const Text(
                        'ข้าม',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Page indicators
          Row(
            children: List.generate(
              _numPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 8),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? _pages[_currentPage].color
                      : Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          // Navigation button
          ElevatedButton(
            onPressed: () {
              if (_currentPage < _numPages - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              } else {
                // Navigate to the home screen or login screen
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _pages[_currentPage].color,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              _currentPage < _numPages - 1 ? 'ถัดไป' : 'เริ่มต้นใช้งาน',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPageData {
  final String title;
  final String description;
  final String illustration;
  final Color color;
  final IconData iconData;

  OnboardingPageData({
    required this.title,
    required this.description,
    required this.illustration,
    required this.color,
    required this.iconData,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData pageData;

  const OnboardingPage({
    super.key,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: pageData.color,
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            // Illustration
            _buildIllustration(size),
            const Spacer(),
            // Content
            _buildContent(),
            // Space for the bottom navigation
            SizedBox(height: size.height * 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(Size size) {
    return Container(
      height: size.height * 0.4,
      padding: const EdgeInsets.all(30),
      child: Image.asset(
        pageData.illustration,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            pageData.iconData,
            size: size.height * 0.3,
            color: Colors.white.withOpacity(0.5),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            pageData.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            pageData.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
