import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notable/src/core/const/app_string.dart';
import 'package:notable/src/core/extension/date_format.dart';
import 'package:notable/src/core/extension/string_extension.dart';
import 'package:notable/src/view/add_note/view/add_note.dart';
import 'package:notable/src/view/note/bloc/note_cubit.dart';
import 'package:notable/src/widget/app_text.dart';

import '../../../model/note_model.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _HomeViewState();
}

class _HomeViewState extends State<NoteView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<NoteCubit>(context).getNotes(context);
  }

  @override
  Widget build(BuildContext context) {
    final noteCubit = BlocProvider.of<NoteCubit>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(
          AppString.notes,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddNoteView()));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: noteCubit.loadingNotifier,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder<String?>(
            valueListenable: noteCubit.errorNotifier,
            builder: (context, error, child) {
              if (error != null) {
                return Center(child: Text(error));
              }

              return ValueListenableBuilder<List<NoteModel>>(
                valueListenable: noteCubit.dataNotifier,
                builder: (context, noteList, child) {
                  return ListView.separated(
                    itemCount: noteList.length,
                    itemBuilder: (context, index) {
                      final note = noteList[index];
                      return ListTile(
                        dense: true,
                        tileColor: Colors.blueGrey,
                        title: AppText(
                          note.title?.capitalizeFirstLetter() ?? 'No Title',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        subtitle: AppText(
                          note.createdAt?.getFormattedDate() ?? "",
                          fontSize: 14,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        AddNoteView(noteModel: note)));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                noteCubit.deleteData(note.id!, context);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 8);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
