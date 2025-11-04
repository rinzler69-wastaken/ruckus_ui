import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  final String name;
  const ProfileTab({super.key, this.name = 'Andi'});

  static const double maxContentWidth =
      400.0; // A smaller width works well for a profile card

  @override
  Widget build(BuildContext context) {
    const nim = '23670145';
    final email = '${name.toLowerCase()}@anymail.com';
    const prodi = 'Teknik Informatika';
    const semester = '5';

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF2A2A2A) : Colors.white;

    return Center(
      // 1. Center the entire content horizontally and vertically
      child: ConstrainedBox(
        // 2. Apply max width constraint
        constraints: const BoxConstraints(maxWidth: maxContentWidth),
        child: SafeArea(
          child: SingleChildScrollView(
            // Use SingleChildScrollView to prevent overflow on small screens
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile Card (Now includes the Logout button)
                Card(
                  color: cardColor,

                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize
                          .min, // Essential to let the Card size itself
                      children: [
                        // Avatar
                        CircleAvatar(
                          radius: 56,
                          backgroundImage: AssetImage(
                            isDark
                                ? 'assets/avatar_dark.png'
                                : 'assets/avatar.png',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'NIM / ID: $nim',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 18),
                        // Info row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Prodi',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  prodi,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 36),
                            Column(
                              children: [
                                Text(
                                  'Semester',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  semester,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24), // Spacer before button
                        // Logout button inside the card
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.logout),
                            label: const Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? Colors.indigoAccent
                                  : Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: Colors.black45,
                            ),
                            onPressed: () => _confirmLogout(context),
                          ),
                        ),
                      ],
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

// ... _confirmLogout function remains the same ...

void _confirmLogout(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
      title: Text(
        'Konfirmasi Logout',
        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      ),
      content: Text(
        'Anda yakin mau logout?',
        style: TextStyle(color: isDark ? Colors.white70 : Colors.black87),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // cancel
          child: Text(
            'Batal',
            style: TextStyle(
              color: isDark ? Colors.indigoAccent : Colors.deepPurple,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            // confirm logout: go back to login and clear stack
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          child: Text(
            'Logout',
            style: TextStyle(
              color: isDark ? Colors.indigoAccent : Colors.deepPurple,
            ),
          ),
        ),
      ],
    ),
  );
}
