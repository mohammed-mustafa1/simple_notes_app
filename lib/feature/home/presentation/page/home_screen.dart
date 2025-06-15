import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/custom_icon.dart';
import 'package:notes_app/core/extenstion/navigation.dart';
import 'package:notes_app/feature/create_note/create_note_screen.dart';
import 'package:notes_app/feature/home/presentation/widgets/empty_state.dart';
import 'package:notes_app/feature/preview/preview_note_screen.dart';
import 'package:notes_app/feature/shared/cubit/note_cubit.dart';
import 'package:notes_app/feature/shared/cubit/note_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NoteCubit>().getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          CustomIconButton(icon: Icons.search, onPressed: () {}),
          SizedBox(width: 21),
          CustomIconButton(icon: Icons.info_outline, onPressed: () {}),
          SizedBox(width: 16),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          context.pushTo(context, CreateNoteScreen());
        },
        child: Icon(
          Icons.add,
          size: 38,
        ),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          var notes = context.read<NoteCubit>().notes;
          return notes.isEmpty
              ? EmptyState()
              : ListView.separated(
                  itemCount: notes.length,
                  padding: EdgeInsets.all(16),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      context.pushTo(
                          context,
                          PreviewNoteScreen(
                            note: notes[index],
                            noteIndex: index,
                          ));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notes[index].title,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            notes[index].description,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                );
        },
      ),
    );
  }
}
