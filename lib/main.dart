import 'package:climathon_admin/constants/colors.dart';
import 'package:climathon_admin/pages/app.dart';
import 'package:climathon_admin/providers/data.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClimathonDataProvider()),
      ],
      child: MaterialApp(
        title: 'Climathon admin',
        theme: ThemeData(
          primarySwatch: generateMaterialColor(color: ClimathonColors.primary),
        ),
        home: const ClimathonApp(),
      ),
    );
  }
}
