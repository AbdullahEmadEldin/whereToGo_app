import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps_app/firebase_options.dart';
import 'package:maps_app/theme/app_theme.dart';
import 'package:maps_app/theme/theme_manager.dart';
import 'package:maps_app/util/navigation/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MapsApp());
}

ThemeManager _themeManager = ThemeManager();

class MapsApp extends StatefulWidget {
  const MapsApp({super.key});

  @override
  State<MapsApp> createState() => _MapsAppState();
}

class _MapsAppState extends State<MapsApp> {
  @override

  ///these listners for switching theme
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light(),
      darkTheme: AppThemes.dark(),
      themeMode: _themeManager.themeMode,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Switch(
              value: _themeManager.themeMode == ThemeMode.dark,
              onChanged: (isDark) {
                _themeManager.toggleTheme(isDark);
              })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              'counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 40,
              width: 150,
              color: kLightColorScheme.secondaryContainer,
              child: Center(
                child: Text(
                  'This Theme testing ',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
