import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps_app/firebase_options.dart';
import 'package:maps_app/generated/l10n.dart';
import 'package:maps_app/theme/app_theme.dart';
import 'package:maps_app/theme/theme_manager.dart';
import 'package:maps_app/util/locator.dart';
import 'package:maps_app/util/navigation/router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

String _initialRoute = '/phoneEnterScreen';
void main() async {
  setUp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen(
    (user) {
      if (user != null) _initialRoute = '/homeScreen';
    },
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
      locale: Locale('en'),
      routerConfig: AppRouter.router(_initialRoute),
      debugShowCheckedModeBanner: false,
      theme: locator.get<ThemeData>(),
      darkTheme: AppThemes.darkAppTheme,
      themeMode: _themeManager.themeMode,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
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
