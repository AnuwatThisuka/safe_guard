import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class EmergencyMapScreen extends StatefulWidget {
  const EmergencyMapScreen({super.key});

  @override
  State<EmergencyMapScreen> createState() => _EmergencyMapScreenState();
}

class _EmergencyMapScreenState extends State<EmergencyMapScreen> {
  final MapController _mapController = MapController();

  // Default location (can be updated with user's real location)
  static const LatLng _defaultLocation = LatLng(13.7563, 100.5018); // Bangkok
  LatLng _currentLocation = _defaultLocation;

  final List<Marker> _emergencyMarkers = [];

  // Emergency facility types with their icons
  final List<EmergencyFacility> _emergencyFacilities = [
    EmergencyFacility(
      name: "โรงพยาบาล",
      icon: Icons.local_hospital,
      color: Colors.red,
    ),
    EmergencyFacility(
      name: "สถานีตำรวจ",
      icon: Icons.local_police,
      color: Colors.blue,
    ),
    EmergencyFacility(
      name: "สถานีดับเพลิง",
      icon: Icons.fire_truck,
      color: Colors.orange,
    ),
    EmergencyFacility(
      name: "ศูนย์พักพิง",
      icon: Icons.home,
      color: Colors.green,
    ),
  ];

  int _selectedFacilityIndex = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    // In a real app, you would load actual emergency location data here
    _loadEmergencyLocations();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Check if location service is enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });

      // Move map to current location
      _mapController.move(_currentLocation, 15);
    } catch (e) {
      print("Error getting location: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadEmergencyLocations() {
    // Simulate loading emergency locations
    // In a real app, you would fetch this data from an API

    // Sample hospital locations around Bangkok
    final List<EmergencyLocation> sampleLocations = [
      EmergencyLocation(
        name: "โรงพยาบาลศิริราช",
        latLng: const LatLng(13.7592, 100.4852),
        type: "โรงพยาบาล",
        address: "2 ถนนวังหลัง กรุงเทพฯ",
        phone: "02-419-7000",
      ),
      EmergencyLocation(
        name: "โรงพยาบาลบำรุงราษฎร์",
        latLng: const LatLng(13.7503, 100.5506),
        type: "โรงพยาบาล",
        address: "33 สุขุมวิท ซอย 3 กรุงเทพฯ",
        phone: "02-066-8888",
      ),
      EmergencyLocation(
        name: "สถานีตำรวจทองหล่อ",
        latLng: const LatLng(13.7321, 100.5797),
        type: "สถานีตำรวจ",
        address: "ถนนสุขุมวิท กรุงเทพฯ",
        phone: "02-390-2240",
      ),
      EmergencyLocation(
        name: "สถานีดับเพลิงพระโขนง",
        latLng: const LatLng(13.7147, 100.5850),
        type: "สถานีดับเพลิง",
        address: "ถนนสุขุมวิท กรุงเทพฯ",
        phone: "02-311-0031",
      ),
      EmergencyLocation(
        name: "ศูนย์พักพิงฉุกเฉิน 1",
        latLng: const LatLng(13.7401, 100.5603),
        type: "ศูนย์พักพิง",
        address: "สุขุมวิท 39 กรุงเทพฯ",
        phone: "02-123-4567",
      ),
    ];

    setState(() {
      _emergencyMarkers.clear();

      for (final location in sampleLocations) {
        final color = location.type == "โรงพยาบาล"
            ? Colors.red
            : location.type == "สถานีตำรวจ"
                ? Colors.blue
                : location.type == "สถานีดับเพลิง"
                    ? Colors.orange
                    : Colors.green;

        final marker = Marker(
          width: 40.0,
          height: 40.0,
          point: location.latLng,
          child: GestureDetector(
            onTap: () => _showLocationInfoDialog(location),
            child: Icon(
              _getIconForType(location.type),
              color: color,
              size: 32,
            ),
          ),
        );

        _emergencyMarkers.add(marker);
      }
    });
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case "โรงพยาบาล":
        return Icons.local_hospital;
      case "สถานีตำรวจ":
        return Icons.local_police;
      case "สถานีดับเพลิง":
        return Icons.fire_truck;
      case "ศูนย์พักพิง":
        return Icons.home;
      default:
        return Icons.location_on;
    }
  }

  void _showLocationInfoDialog(EmergencyLocation location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(location.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ที่อยู่: ${location.address}"),
              const SizedBox(height: 8),
              Text("เบอร์โทร: ${location.phone}"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("ปิด"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("โทร", style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("กำลังโทรไปที่ ${location.phone}")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _filterMarkers(String facilityType) {
    // This function would filter markers based on facility type
    // In a real app, you might fetch different markers from an API
    setState(() {
      // Update filter state
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'แผนที่ฉุกเฉิน',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {
                // Show emergency call dialog
                _showEmergencyCallDialog();
              },
            ),
          ],
        ),
        body: Stack(
          children: [
            // Flutter Map
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: _currentLocation,
                      initialZoom: 15.0,
                      minZoom: 5.0,
                      maxZoom: 18.0,
                      onTap: (tapPosition, point) {
                        // Handle map tap
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.safeguard.app',
                      ),
                      MarkerLayer(
                        markers: _emergencyMarkers,
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: _currentLocation,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.my_location,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

            // Facility type filter at the top
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _emergencyFacilities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ChoiceChip(
                        checkmarkColor: Colors.white,
                        backgroundColor: Colors.white,
                        label: Row(
                          children: [
                            Icon(
                              _emergencyFacilities[index].icon,
                              color: _selectedFacilityIndex == index
                                  ? Colors.white
                                  : _emergencyFacilities[index].color,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _emergencyFacilities[index].name,
                              style: TextStyle(
                                color: _selectedFacilityIndex == index
                                    ? Colors.white
                                    : _emergencyFacilities[index].color,
                              ),
                            )
                          ],
                        ),
                        selected: _selectedFacilityIndex == index,
                        selectedColor: _emergencyFacilities[index].color,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedFacilityIndex = selected ? index : 0;
                            _filterMarkers(_emergencyFacilities[index].name);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            // Float action buttons
            Positioned(
              right: 16,
              bottom: 100,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "location",
                    onPressed: () async {
                      await _getCurrentLocation();
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.my_location, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  FloatingActionButton(
                    heroTag: "sos",
                    onPressed: () {
                      // Show SOS action dialog
                      _showSOSDialog();
                    },
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.sos, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmergencyCallDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("เบอร์โทรฉุกเฉิน"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEmergencyContactTile("ตำรวจ", "191", Icons.local_police),
              _buildEmergencyContactTile(
                  "แพทย์ฉุกเฉิน", "1669", Icons.local_hospital),
              _buildEmergencyContactTile("ดับเพลิง", "199", Icons.fire_truck),
              _buildEmergencyContactTile(
                  "ตำรวจท่องเที่ยว", "1155", Icons.travel_explore),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("ปิด"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEmergencyContactTile(
      String title, String number, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      subtitle: Text(number),
      trailing: IconButton(
        icon: const Icon(Icons.call, color: Colors.green),
        onPressed: () {
          // In a real app, implement actual phone call functionality
          // For example: url_launcher package to launch phone URL
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("กำลังโทรไปที่ $number")),
          );
        },
      ),
    );
  }

  void _showSOSDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("แจ้งเหตุฉุกเฉิน",
              style: TextStyle(color: Colors.red)),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 60),
              SizedBox(height: 16),
              Text("ส่งการแจ้งเตือนฉุกเฉินพร้อมตำแหน่งปัจจุบันของคุณ?"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("ยกเลิก"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("ส่ง SOS", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                // In a real app, implement actual SOS alert functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("ส่งสัญญาณแจ้งเตือนฉุกเฉินแล้ว")),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class EmergencyFacility {
  final String name;
  final IconData icon;
  final Color color;

  EmergencyFacility({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class EmergencyLocation {
  final String name;
  final LatLng latLng;
  final String type;
  final String address;
  final String phone;

  EmergencyLocation({
    required this.name,
    required this.latLng,
    required this.type,
    required this.address,
    required this.phone,
  });
}
