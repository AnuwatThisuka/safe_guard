import 'package:flutter/material.dart';

class AlertsChatScreen extends StatelessWidget {
  const AlertsChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('การแจ้งเตือน & แชท'),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(
                icon: Icon(Icons.notifications_active),
                text: 'การแจ้งเตือน',
              ),
              Tab(
                icon: Icon(Icons.chat_bubble),
                text: 'แชทฉุกเฉิน',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_AlertsTab(), _ChatTab()],
        ),
      ),
    );
  }
}

class _AlertsTab extends StatelessWidget {
  const _AlertsTab();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.3),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'การแจ้งเตือนจะปรากฏที่นี่โดยอัตโนมัติ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildAlertsList(context),
        ),
      ],
    );
  }

  Widget _buildAlertsList(BuildContext context) {
    final alertTypes = [
      {
        'icon': Icons.warning_amber,
        'color': Colors.red,
        'title': 'เเจ้งเตือนฉุกเฉิน',
        'message': 'พบเหตุเพลิงไหม้ในบริเวณใกล้เคียง โปรดหลีกเลี่ยงพื้นที่',
        'time': DateTime.now().subtract(const Duration(minutes: 5))
      },
      {
        'icon': Icons.local_police,
        'color': Colors.blue,
        'title': 'แจ้งเตือนความปลอดภัย',
        'message': 'มีการแจ้งเหตุอาชญากรรมในพื้นที่ โปรดระมัดระวัง',
        'time': DateTime.now().subtract(const Duration(hours: 2))
      },
      {
        'icon': Icons.health_and_safety,
        'color': Colors.orange,
        'title': 'เเจ้งเตือนสุขภาพ',
        'message': 'คุณภาพอากาศแย่ในพื้นที่ของคุณ ควรหลีกเลี่ยงการออกนอกอาคาร',
        'time': DateTime.now().subtract(const Duration(hours: 12))
      },
      {
        'icon': Icons.water_drop,
        'color': Colors.indigo,
        'title': 'เเจ้งเตือนน้ำท่วม',
        'message': 'มีโอกาสน้ำท่วมในพื้นที่ของคุณในช่วง 24 ชั่วโมงข้างหน้า',
        'time': DateTime.now().subtract(const Duration(days: 1))
      },
      {
        'icon': Icons.coronavirus,
        'color': Colors.purple,
        'title': 'เเจ้งเตือนสุขภาพ',
        'message': 'มีการแจ้งเตือนโรคระบาดในพื้นที่ของคุณ',
        'time': DateTime.now().subtract(const Duration(days: 2))
      },
    ];

    if (alertTypes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            const Text(
              'ไม่มีการแจ้งเตือนในขณะนี้',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: alertTypes.length,
      itemBuilder: (context, index) {
        final alert = alertTypes[index];
        return _AlertCard(
          icon: alert['icon'] as IconData,
          color: alert['color'] as Color,
          title: alert['title'] as String,
          message: alert['message'] as String,
          time: alert['time'] as DateTime,
        );
      },
    );
  }
}

class _AlertCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final DateTime time;

  const _AlertCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showAlertDetails(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.2),
                    child: Icon(icon, color: color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatTime(time),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: const Size(0, 30),
                          ),
                          child: const Text('ดูแผนที่'),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.more_vert, size: 18),
                          constraints: const BoxConstraints(
                            minHeight: 30,
                            minWidth: 30,
                          ),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _showAlertOptions(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  // Pull indicator
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),

                  // Alert header
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: color.withOpacity(0.2),
                          radius: 24,
                          child: Icon(icon, color: color, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                _formatTime(time),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Emergency Map
                  Container(
                    height: 250,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Colors.grey[300],
                            child:
                                const Center(child: Text('แผนที่จะแสดงที่นี่')),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Card(
                            child: IconButton(
                              icon: const Icon(Icons.fullscreen),
                              onPressed: () {
                                // Handle map fullscreen
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: Column(
                            children: [
                              Card(
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    // Handle zoom in
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              Card(
                                child: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    // Handle zoom out
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Card(
                            child: IconButton(
                              icon: const Icon(Icons.my_location),
                              onPressed: () {
                                // Handle center on user location
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Alert details
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'รายละเอียดการแจ้งเตือน',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(message),
                        const SizedBox(height: 16),
                        const Text(
                          'คำแนะนำ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'โปรดปฏิบัติตามคำแนะนำของเจ้าหน้าที่และติดตามข้อมูลล่าสุด',
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.phone),
                                label: const Text('โทรฉุกเฉิน'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.all(16),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: const Icon(Icons.message),
                                label: const Text('แชทฉุกเฉิน'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(16),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAlertOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.mark_chat_read),
                title: const Text('ทำเครื่องหมายว่าอ่านแล้ว'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_off),
                title: const Text('ปิดการแจ้งเตือนประเภทนี้'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('แชร์การแจ้งเตือน'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} นาทีที่แล้ว';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ชั่วโมงที่แล้ว';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} วันที่แล้ว';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
}

class _ChatTab extends StatefulWidget {
  const _ChatTab();

  @override
  State<_ChatTab> createState() => _ChatTabState();
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final DateTime time;
  final bool hasRead;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
    this.hasRead = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              radius: 16,
              child: const Icon(Icons.support_agent,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isUser
                        ? theme.colorScheme.primary
                        : theme.colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20).copyWith(
                      bottomRight: isUser ? const Radius.circular(0) : null,
                      bottomLeft: !isUser ? const Radius.circular(0) : null,
                    ),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatMessageTime(time),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (isUser) ...[
                      const SizedBox(width: 4),
                      Icon(
                        hasRead ? Icons.done_all : Icons.done,
                        size: 12,
                        color: hasRead ? Colors.blue : Colors.grey[400],
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser)
            const CircleAvatar(
              radius: 16,
              child: Icon(Icons.person, color: Colors.white, size: 16),
            ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(time.year, time.month, time.day);

    if (messageDate == today) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'เมื่อวาน ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      return '${time.day}/${time.month} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
}

class QuickReplyOptions extends StatelessWidget {
  final Function(String) onSelected;

  const QuickReplyOptions({required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'ข้อความด่วน:',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                _buildQuickReplyChip('ฉันต้องการความช่วยเหลือทันที', theme),
                _buildQuickReplyChip('ฉันอยู่ในสถานการณ์ฉุกเฉิน', theme),
                _buildQuickReplyChip('ขอเบอร์ติดต่อฉุกเฉิน', theme),
                _buildQuickReplyChip('รายงานเหตุฉุกเฉิน', theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickReplyChip(String text, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        label: Text(text),
        // ignore: deprecated_member_use
        backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.3),
        // ignore: deprecated_member_use
        side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.3)),
        onPressed: () => onSelected(text),
      ),
    );
  }
}

class _ChatTabState extends State<_ChatTab> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: text,
          isUser: true,
          time: DateTime.now(),
          hasRead: true,
        ));
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return _messages[index];
            },
          ),
        ),
        QuickReplyOptions(
          onSelected: (text) {
            _sendMessage(text);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'พิมพ์ข้อความ...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _sendMessage(_controller.text);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
