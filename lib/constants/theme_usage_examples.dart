import 'package:flutter/material.dart';
import 'app_theme.dart';

// Example: How to use the custom theme extension in widgets
class ThemeUsageExamples {
  // Example 1: Using background colors
  static Widget backgroundExample(BuildContext context) {
    return Container(
      color: context.theme.bg, // Custom background
      child: const Text('Background with custom color'),
    );
  }

  // Example 2: Using green palette
  static Widget greenPaletteExample(BuildContext context) {
    return Column(
      children: [
        Container(
          color: context.theme.greenPrimary,
          child: const Text('Primary Green'),
        ),
        Container(
          color: context.theme.greenSecondary,
          child: const Text('Secondary Green'),
        ),
        Container(
          color: context.theme.greenTertiary,
          child: const Text('Tertiary Green'),
        ),
      ],
    );
  }

  // Example 3: Using semantic colors
  static Widget semanticColorsExample(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check, color: context.theme.success),
        Icon(Icons.warning, color: context.theme.warning),
        Icon(Icons.error, color: context.theme.error),
        Icon(Icons.info, color: context.theme.info),
      ],
    );
  }

  // Example 4: Using pastel colors for clothing categories
  static Widget categoryColorsExample(BuildContext context) {
    return Wrap(
      children: [
        Chip(
          label: const Text('Tops'),
          backgroundColor: context.theme.pastelGreenPrimary,
        ),
        Chip(
          label: const Text('Bottoms'),
          backgroundColor: context.theme.pastelGreenSecondary,
        ),
        Chip(
          label: const Text('Shoes'),
          backgroundColor: context.theme.pastelMint,
        ),
        Chip(
          label: const Text('Accessories'),
          backgroundColor: context.theme.pastelSage,
        ),
      ],
    );
  }

  // Example 5: Creating themed buttons
  static Widget themedButtonsExample(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.theme.greenPrimary,
            foregroundColor: context.theme.bg,
          ),
          onPressed: () {},
          child: const Text('Primary Action'),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: context.theme.greenSecondary),
            foregroundColor: context.theme.greenSecondary,
          ),
          onPressed: () {},
          child: const Text('Secondary Action'),
        ),
      ],
    );
  }

  // Example 6: Using text colors
  static Widget textColorsExample(BuildContext context) {
    return Column(
      children: [
        Text(
          'Primary text',
          style: TextStyle(color: context.theme.textColor),
        ),
        Text(
          'Success message',
          style: TextStyle(color: context.theme.success),
        ),
        Text(
          'Warning message',
          style: TextStyle(color: context.theme.warning),
        ),
        Text(
          'Error message',
          style: TextStyle(color: context.theme.error),
        ),
      ],
    );
  }

  // Example 7: Creating cards with theme colors
  static Widget themedCardExample(BuildContext context) {
    return Card(
      color: context.theme.surface,
      shadowColor: context.theme.shadow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Themed Card',
              style: TextStyle(
                color: context.theme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 4,
              decoration: BoxDecoration(
                color: context.theme.greenPrimary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
