import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Categories
            Row(
              children: [
                Expanded(
                  child: _buildCategoryCard(
                    title: 'HR Documents',
                    count: '12 files',
                    icon: Icons.assignment,
                    color: AppTheme.primaryRed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCategoryCard(
                    title: 'Policies',
                    count: '5 files',
                    icon: Icons.policy,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Document List
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Recent Documents',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDocumentItem(
                    title: 'Employee Handbook 2024',
                    subtitle: 'HR Documents • PDF • 2.5 MB',
                    icon: Icons.picture_as_pdf,
                    date: '2 days ago',
                  ),
                  _buildDocumentItem(
                    title: 'Leave Policy',
                    subtitle: 'Policies • PDF • 1.2 MB',
                    icon: Icons.picture_as_pdf,
                    date: '1 week ago',
                  ),
                  _buildDocumentItem(
                    title: 'Code of Conduct',
                    subtitle: 'HR Documents • PDF • 3.1 MB',
                    icon: Icons.picture_as_pdf,
                    date: '2 weeks ago',
                  ),
                  _buildDocumentItem(
                    title: 'Benefits Overview',
                    subtitle: 'HR Documents • PDF • 1.8 MB',
                    icon: Icons.picture_as_pdf,
                    date: '3 weeks ago',
                  ),
                  _buildDocumentItem(
                    title: 'Remote Work Policy',
                    subtitle: 'Policies • PDF • 0.9 MB',
                    icon: Icons.picture_as_pdf,
                    date: '1 month ago',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add document
        },
        backgroundColor: AppTheme.primaryRed,
        child: const Icon(Icons.add, color: AppTheme.white),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required String date,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.primaryRed, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              const Icon(
                Icons.more_vert,
                color: AppTheme.textSecondary,
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
