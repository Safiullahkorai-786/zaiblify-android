import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme/app_theme.dart';

class ZaiblifyApp extends StatelessWidget {
  const ZaiblifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zaiblify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const StartupGate(),
    );
  }
}

class StartupGate extends StatefulWidget {
  const StartupGate({super.key});

  @override
  State<StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<StartupGate> {
  bool _ready = false;
  bool _seenTour = false;

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _seenTour = prefs.getBool('seen_tour') ?? false;
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const SplashScreen();
    return _seenTour ? const ShellScreen() : const TourScreen();
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [scheme.surface, scheme.primaryContainer.withOpacity(.45), scheme.surface],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LogoMark(size: 88),
              const SizedBox(height: 24),
              Text('zaiblify', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1.5)),
              const SizedBox(height: 8),
              Text('Make words feel like you.', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
  final _pageController = PageController();
  int _page = 0;

  final _pages = const [
    _TourPage(icon: Icons.auto_awesome_rounded, title: 'Your words,\nyour style.', body: 'Turn ordinary text into bold, italic, script, bubble, and more in seconds.'),
    _TourPage(icon: Icons.touch_app_rounded, title: 'Works where\nyou write.', body: 'Select text in a supported app, choose Zaiblify, and transform it without leaving your flow.'),
    _TourPage(icon: Icons.palette_rounded, title: 'Simple. Beautiful.\nPersonal.', body: 'A calm interface with system-aware light and dark themes, made for everyday use.'),
  ];

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_tour', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const ShellScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(alignment: Alignment.centerRight, child: TextButton(onPressed: _finish, child: const Text('Skip'))),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (value) => setState(() => _page = value),
                itemBuilder: (_, index) => _pages[index],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(_pages.length, (index) => AnimatedContainer(duration: const Duration(milliseconds: 250), margin: const EdgeInsets.all(4), width: _page == index ? 28 : 8, height: 8, decoration: BoxDecoration(color: _page == index ? scheme.primary : scheme.outlineVariant, borderRadius: BorderRadius.circular(20))))),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
              child: FilledButton(onPressed: () { if (_page == _pages.length - 1) { _finish(); } else { _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic); } }, child: Text(_page == _pages.length - 1 ? 'Get started' : 'Continue')),
            ),
          ],
        ),
      ),
    );
  }
}

class _TourPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _TourPage({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 150, height: 150, decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [scheme.primaryContainer, scheme.secondaryContainer]), boxShadow: [BoxShadow(color: scheme.primary.withOpacity(.15), blurRadius: 40)]), child: Icon(icon, size: 68, color: scheme.primary)),
        const SizedBox(height: 48),
        Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, height: 1.05, letterSpacing: -1.5)),
        const SizedBox(height: 20),
        Text(body, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5, color: scheme.onSurfaceVariant)),
      ]),
    );
  }
}

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _index = 0;
  final _screens = const [HomeScreen(), StylesScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface.withOpacity(.88), borderRadius: BorderRadius.circular(28), border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(.55)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 24, offset: const Offset(0, 8))]),
          child: NavigationBarTheme(data: NavigationBarThemeData(backgroundColor: Colors.transparent, elevation: 0, indicatorColor: Theme.of(context).colorScheme.primaryContainer), child: NavigationBar(selectedIndex: _index, onDestinationSelected: (value) => setState(() => _index = value), destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Home'), NavigationDestination(icon: Icon(Icons.text_fields_rounded), label: 'Styles'), NavigationDestination(icon: Icon(Icons.tune_rounded), label: 'Settings')])),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(24, 28, 24, 120), children: [
      Row(children: [const _LogoMark(size: 42), const SizedBox(width: 12), Text('zaiblify', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1))]),
      const SizedBox(height: 42),
      Text('Make your words\nstand out.', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, height: 1.05, letterSpacing: -1.6)),
      const SizedBox(height: 16),
      Text('A tiny toolkit for expressive text. Select, style, and share.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant, height: 1.4)),
      const SizedBox(height: 32),
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(gradient: LinearGradient(colors: [scheme.primaryContainer, scheme.secondaryContainer]), borderRadius: BorderRadius.circular(28)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Quick start', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)), const SizedBox(height: 12), Text('Select text in any supported app, tap Zaiblify, then pick a style.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4)), const SizedBox(height: 18), Row(children: [Icon(Icons.touch_app_rounded, color: scheme.primary), const SizedBox(width: 8), Text('Ready when you are', style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700))])])),
      const SizedBox(height: 32),
      Text('Popular styles', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 14),
      const Row(children: [Expanded(child: _StyleCard(label: 'Bold', preview: '𝐇𝐞𝐥𝐥𝐨')), SizedBox(width: 12), Expanded(child: _StyleCard(label: 'Script', preview: '𝓗𝓮𝓵𝓵𝓸'))]),
    ]));
  }
}

class StylesScreen extends StatelessWidget {
  const StylesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final styles = const [('Bold', '𝐇𝐞𝐥𝐥𝐨'), ('Italic', '𝘏𝘦𝘭𝘭𝘰'), ('Bold Italic', '𝙃𝙚𝙡𝙡𝙤'), ('Script', '𝓗𝓮𝓵𝓵𝓸'), ('Double-struck', 'ℍ𝕖𝕝𝕝𝕠'), ('Fraktur', '𝔥𝔢𝔩𝔩𝔬'), ('Small caps', 'ʜᴇʟʟᴏ'), ('Fullwidth', 'Ｈｅｌｌｏ')];
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(24, 28, 24, 120), children: [Text('Styles', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1.5)), const SizedBox(height: 10), Text('A preview gallery for the Zaiblify style engine.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)), const SizedBox(height: 28), ...styles.map((style) => Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(.45), borderRadius: BorderRadius.circular(20), border: Border.all(color: Theme.of(context).colorScheme.outlineVariant.withOpacity(.4))), child: Row(children: [Expanded(child: Text(style.$2, style: Theme.of(context).textTheme.titleLarge)), Text(style.$1, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.primary))])))]));
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(24, 28, 24, 120), children: [Text('Settings', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -1.5)), const SizedBox(height: 28), const _SettingsTile(icon: Icons.brightness_6_rounded, title: 'Appearance', subtitle: 'System default for now'), const _SettingsTile(icon: Icons.auto_awesome_rounded, title: 'Formatting engine', subtitle: 'Unicode styles · Offline'), const _SettingsTile(icon: Icons.info_outline_rounded, title: 'About Zaiblify', subtitle: 'Version 0.1.0')]);
}

class _SettingsTile extends StatelessWidget { final IconData icon; final String title; final String subtitle; const _SettingsTile({required this.icon, required this.title, required this.subtitle}); @override Widget build(BuildContext context) => ListTile(contentPadding: const EdgeInsets.symmetric(vertical: 8), leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primaryContainer, child: Icon(icon, color: Theme.of(context).colorScheme.primary)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(subtitle)); }
class _StyleCard extends StatelessWidget { final String label; final String preview; const _StyleCard({required this.label, required this.preview}); @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(.45), borderRadius: BorderRadius.circular(22)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(preview, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12), Text(label, style: Theme.of(context).textTheme.labelLarge)])); }
class _LogoMark extends StatelessWidget { final double size; const _LogoMark({required this.size}); @override Widget build(BuildContext context) { final scheme = Theme.of(context).colorScheme; return Container(width: size, height: size, decoration: BoxDecoration(borderRadius: BorderRadius.circular(size * .28), gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [scheme.primary, scheme.tertiary]), boxShadow: [BoxShadow(color: scheme.primary.withOpacity(.25), blurRadius: 18, offset: const Offset(0, 8))]), child: Icon(Icons.auto_awesome_rounded, size: size * .48, color: scheme.onPrimary)); } }
