import 'package:flutter/material.dart';

class DataTab extends StatelessWidget {
  const DataTab({super.key});

  // Dummy data
  final List<Map<String, dynamic>> _records = const [
    {'id': '001', 'name': 'Alice', 'status': 'active', 'date': '01/11/2025'},
    {'id': '002', 'name': 'Bob', 'status': 'pending', 'date': '02/11/2025'},
    {
      'id': '003',
      'name': 'Charlie',
      'status': 'inactive',
      'date': '03/11/2025',
    },
    {'id': '004', 'name': 'Diana', 'status': 'active', 'date': '04/11/2025'},
    {'id': '005', 'name': 'Eve', 'status': 'pending', 'date': '05/11/2025'},
  ];

  Color _statusColor(String status, BuildContext context) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'inactive':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'active':
        return Icons.check_circle;
      case 'pending':
        return Icons.hourglass_top;
      case 'inactive':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  static const double maxContentWidth = 720.0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF2A2A2A) : Colors.white;

    return Center(
      // 1. Center the content
      child: ConstrainedBox(
        // 2. Apply max width constraint
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: Column(
          children: [
            // Wrap banner in Material to get elevation
            Padding(
              padding: const EdgeInsets.all(16), // same margin as before
              child: Material(
                elevation: 4, // shadow depth
                borderRadius: BorderRadius.circular(12),
                clipBehavior:
                    Clip.antiAlias, // ensures image respects border radius
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        isDark ? 'assets/banner_dark.png' : 'assets/banner.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Dummy Data Records (soz)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // List of records
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _records.length,
                itemBuilder: (context, index) {
                  final record = _records[index];
                  final status = record['status'] as String;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: cardColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        _statusIcon(status),
                        color: _statusColor(status, context),
                      ),
                      title: Text(
                        record['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'ID: ${record['id']} • ${record['date']}',
                        style: TextStyle(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Detail clicked: ${record['name']}'),
                            backgroundColor: isDark
                                ? Colors.grey.shade200
                                : Colors.grey.shade800,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
