import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/core/services/loca_storage.dart';
import 'package:notes_app/core/utils/app_colors.dart';
import 'package:notes_app/feature/home/presentation/page/home_screen.dart';
import 'package:notes_app/feature/shared/cubit/note_cubit.dart';
import 'package:notes_app/feature/shared/model/note_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  await Hive.openBox<NoteModel>(LocalStorage.notesBox);
  await LocalStorage.init();

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteCubit(),
      child: MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.primaryColor,
          appBarTheme: AppBarTheme(
            color: AppColors.primaryColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
