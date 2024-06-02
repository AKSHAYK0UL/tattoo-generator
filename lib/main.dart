import 'package:artbot/UI/generated_images_screen.dart';
import 'package:artbot/UI/image_preview_screen.dart';
import 'package:artbot/UI/prompt_screen.dart';
import 'package:artbot/UI/setting_screen.dart';
import 'package:artbot/bloc/gimage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GimageBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const PromptScreen(),
        routes: {
          ImagesScreen.routeName: (context) => const ImagesScreen(),
          ImagePreviewScreen.routeName: (context) => const ImagePreviewScreen(),
          SettingScreen.routeName: (context) => const SettingScreen(),
        },
      ),
    );
  }
}
