import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome, Davin! 👋",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            "Here's your overview",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatCard(
                "12",
                "COURSES",
                "3 in progress",
                const Color(0xFFD2E3FF),
                const Color(0xFFA1C6FF),
                '📚',
                const Color(0xFF1B2559),
                const Color(0xFF4376E2),
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                "3.8",
                "GPA",
                "Top 15%",
                const Color(0xFFFCE1EF),
                const Color(0xFFF5B5D6),
                '🏆',
                const Color(0xFF852243),
                const Color(0xFFD24A79),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildListTile(
                  Icons.access_time,
                  "Recent Activity",
                  "2 new updates",
                  bgColor: Color(0xFFD2E3FF),
                ),
                const Divider(height: 1, indent: 70, endIndent: 30),
                _buildListTile(
                  Icons.edit_document,
                  "Assignments",
                  "3 pending",
                  bgColor: Colors.yellowAccent.shade100,
                ),
                const Divider(height: 1, indent: 70, endIndent: 30),
                _buildListTile(Icons.settings, "Settings", "Profile & prefs"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String title,
    String subtitle,
    Color bgColor,
    Color borderColor,
    String emoji,
    Color valueColor,
    Color titleColor,
  ) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2.0, color: borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: valueColor,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 50,
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                textAlign: TextAlign.center,
                emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    IconData icon,
    String title,
    String subtitle, {
    Color iconColor = Colors.grey,
    Color bgColor = Colors.white,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 4),
          ],
        ),
        child: Icon(icon, color: iconColor),
      ),
      onTap: () {},
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
