import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/auth_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with enhanced styling (matching home screen)
          SliverAppBar.large(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Customize your experience',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            backgroundColor: colorScheme.surface,
            surfaceTintColor: colorScheme.surfaceTint,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            snap: false,
            elevation: 0,
            scrolledUnderElevation: 1,
          ),

          // Content Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSection(
                    'General',
                    [
                      BlocBuilder<ThemeCubit, bool>(
                        builder: (context, isDarkMode) {
                          return _buildSettingsTile(
                            icon: Icons.dark_mode,
                            title: 'Theme',
                            subtitle: isDarkMode ? 'Dark mode' : 'Light mode',
                            trailing: Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                context.read<ThemeCubit>().toggleTheme();
                              },
                              thumbColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return colorScheme.primary;
                                }
                                return colorScheme.outline;
                              }),
                              trackColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return colorScheme.primary
                                      .withValues(alpha: 0.5);
                                }
                                return colorScheme.surfaceContainerHighest;
                              }),
                            ),
                          );
                        },
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
                          thumbColor:
                              WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return colorScheme.primary;
                            }
                            return colorScheme.outline;
                          }),
                          trackColor:
                              WidgetStateProperty.resolveWith<Color>((states) {
                            if (states.contains(WidgetState.selected)) {
                              return colorScheme.primary.withValues(alpha: 0.5);
                            }
                            return colorScheme.surfaceContainerHighest;
                          }),
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
                    'Account',
                    [
                      _buildSettingsTile(
                        icon: Icons.logout,
                        title: 'Sign Out',
                        subtitle: 'Sign out of your account',
                        onTap: () => _showSignOutDialog(context),
                        trailing: const Icon(Icons.logout, color: Colors.red),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.12),
                width: 1,
              ),
              color: colorScheme.surface,
            ),
            child: Column(children: children),
          ),
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

  void _showSignOutDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        icon: Icon(
          Icons.logout,
          color: colorScheme.primary,
          size: 32,
        ),
        title: Text(
          'Sign Out?',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out? You will need to sign in again to access your wardrobe.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Close the dialog

              try {
                await context.read<AuthCubit>().signOut();
                // The auth state change will be handled by the AuthWrapper
                // which will navigate back to the AuthScreen
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to sign out: $e'),
                      backgroundColor: colorScheme.error,
                    ),
                  );
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
