import 'package:flutter/material.dart';

import '../../core/privacy/consent_store.dart';

/// Explicit consent screen shown before any advertising SDK is enabled.
class ConsentScreen extends StatefulWidget {
  final VoidCallback onCompleted;

  const ConsentScreen({super.key, required this.onCompleted});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  bool _saving = false;

  Future<void> _complete({required bool accepted}) async {
    setState(() => _saving = true);
    await ConsentStore.setAdvertisingConsent(accepted);
    if (!mounted) return;
    widget.onCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy choices')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Icon(Icons.privacy_tip_outlined, size: 64, color: scheme.primary),
            const SizedBox(height: 24),
            Text('Your privacy matters', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            const Text('Zaiblify works offline. Advertising is currently disabled. If ads are introduced later, we will ask for your choice before enabling advertising services.'),
            const SizedBox(height: 20),
            Card(child: Padding(padding: const EdgeInsets.all(16), child: Text('You can change this choice later in Settings. Read the privacy policy for details.', style: TextStyle(color: scheme.onSurfaceVariant)))),
            const SizedBox(height: 28),
            FilledButton(onPressed: _saving ? null : () => _complete(accepted: true), child: const Text('Allow future relevant ads')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _saving ? null : () => _complete(accepted: false), child: const Text('Do not allow ads')),
          ],
        ),
      ),
    );
  }
}
