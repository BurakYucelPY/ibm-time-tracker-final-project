import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/project_task_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  const TimeTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeEntryProvider()..init()),
        ChangeNotifierProvider(create: (_) => ProjectTaskProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Time Tracker',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
