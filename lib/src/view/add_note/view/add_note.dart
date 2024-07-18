import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/src/view/add_note/bloc/add_note_cubit.dart';

import '../../../core/const/app_string.dart';
import '../../../model/note_model.dart';
import '../../../widget/app_text.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({super.key, this.noteModel});

  final NoteModel? noteModel;

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AddNoteCubit>(context).titleController.text =
        widget.noteModel?.title ?? "";
    BlocProvider.of<AddNoteCubit>(context).bodyController.text =
        widget.noteModel?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final addNoteCubit = BlocProvider.of<AddNoteCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(
          AppString.addNote,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            addNoteCubit.onAddUpdateNoteClick(widget.noteModel, context),
        label: Text(widget.noteModel != null
            ? AppString.updateNote
            : AppString.saveNote),
        icon: const Icon(Icons.save),
      ),
      body: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteLoading) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Column(
              children: [
                TextField(
                  controller: addNoteCubit.titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: AppString.noteTitle,
                  ),
                  style: const TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TextField(
                    controller: addNoteCubit.bodyController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: AppString.writeYourNote,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
