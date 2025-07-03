import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'General',
            [
              _buildSettingsTile(
                icon: Icons.dark_mode,
                title: 'Theme',
                subtitle: 'Dark mode',
                trailing: Switch(
                  value: false,
                  onChanged: (value) {
                    // TODO: Implement theme switching
                  },
                ),
              ),
              _buildSettingsTile(
                icon: Icons.notifications,
                title: 'Notifications',
                subtitle: 'Enable notifications',
                trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    // TODO: Implement notification settings
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Storage',
            [
              _buildSettingsTile(
                icon: Icons.storage,
                title: 'Data Management',
                subtitle: 'Manage your data',
                onTap: () {
                  // TODO: Implement data management
                },
              ),
              _buildSettingsTile(
                icon: Icons.backup,
                title: 'Backup & Sync',
                subtitle: 'Cloud backup settings',
                onTap: () {
                  // TODO: Implement backup settings
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSection(
            'About',
            [
              _buildSettingsTile(
                icon: Icons.info,
                title: 'App Version',
                subtitle: '1.0.0',
                onTap: () {},
              ),
              _buildSettingsTile(
                icon: Icons.help,
                title: 'Help & Support',
                subtitle: 'Get help and support',
                onTap: () {
                  // TODO: Implement help screen
                },
              ),
              _buildSettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                onTap: () {
                  // TODO: Implement privacy policy
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing:
          trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
