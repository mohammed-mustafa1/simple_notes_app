import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/custom_icon.dart';
import 'package:notes_app/core/extenstion/navigation.dart';
import 'package:notes_app/feature/home/presentation/page/home_screen.dart';
import 'package:notes_app/feature/shared/cubit/note_cubit.dart';
import 'package:notes_app/feature/shared/cubit/note_state.dart';
import 'package:notes_app/feature/shared/model/note_model.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteCreated) {
          context.pushReplaceTo(context, HomeScreen());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icons.arrow_back_ios_new,
                ),
                CustomIconButton(
                    icon: Icons.save,
                    onPressed: () async {
                      String id = '${DateTime.now().millisecondsSinceEpoch}';
                      if (formKey.currentState!.validate()) {
                        context.read<NoteCubit>().addNote(
                              NoteModel(
                                  id: id,
                                  title: titleController.text,
                                  description: contentController.text),
                            );
                      }
                    }),
              ],
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(' Title is required')));
                          return '';
                        }
                        return null;
                      },
                      controller: titleController,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(' content is required')));
                          return '';
                        }
                        return null;
                      },
                      controller: contentController,
                      maxLines: 10,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey),
                        hintText: 'Type something',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
