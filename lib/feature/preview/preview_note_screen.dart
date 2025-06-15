import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/core/components/custom_icon.dart';
import 'package:notes_app/feature/shared/cubit/note_cubit.dart';
import 'package:notes_app/feature/shared/cubit/note_state.dart';
import 'package:notes_app/feature/shared/model/note_model.dart';

class PreviewNoteScreen extends StatefulWidget {
  const PreviewNoteScreen({
    super.key,
    required this.note,
    required this.noteIndex,
  });
  final NoteModel note;
  final int noteIndex;
  @override
  State<PreviewNoteScreen> createState() => _PreviewNoteScreenState();
}

class _PreviewNoteScreenState extends State<PreviewNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.note.title;
    contentController.text = widget.note.description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteCubit, NoteState>(
      listener: (context, state) {
        if (state is NoteEdited || state is Notedeleted) {
          context.read<NoteCubit>().getNotes();
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // back button
              CustomIconButton(
                icon: Icons.arrow_back_ios_new,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Row(
                children: [
                  // remove note buutton
                  CustomIconButton(
                    icon: Icons.delete_forever,
                    iconColor: Colors.red,
                    onPressed: () {
                      context.read<NoteCubit>().deleteNote(widget.noteIndex);
                    },
                  ),
                  SizedBox(width: 8),

                  // edit note button
                  CustomIconButton(
                    icon: Icons.edit,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<NoteCubit>().updateNote(
                              widget.noteIndex,
                              NoteModel(
                                  id: widget.note.id,
                                  title: titleController.text,
                                  description: contentController.text),
                            );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
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
          ),
        ),
      ),
    );
  }
}
