// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:zenit/config/app_colors.dart';
import 'package:zenit/config/measures.dart';
import 'package:zenit/services/journal_service.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List<dynamic> _entries = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await JournalService.getEntries();
    setState(() {
      _entries = entries ?? [];
      _loading = false;
    });
  }

  void _openCreateDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        title: Text(
          'Nueva nota',
          style: TextStyle(
            color: AppColors.mainGreen,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Título',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.mainGreen),
                ),
              ),
            ),
            SizedBox(height: 10),

            TextField(
              controller: contentController,
              decoration: InputDecoration(
                hintText: 'Escribe tu nota...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColors.mainGreen),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: AppColors.darkerGrey),
            ),
          ),
          TextButton(
            onPressed: () async {
              final title = titleController.text.trim();
              final content = contentController.text.trim();

              if (title.isEmpty || content.isEmpty) return;

              final success = await JournalService.createEntry(title, content);
              Navigator.pop(context);

              if (success) _loadEntries();
            },
            child: Text(
              'Guardar',
              style: TextStyle(color: AppColors.mainGreen),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = Measures.size(context);
    final width = size.width;
    final scale = Measures.scale(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: scale * 35,
          horizontal: scale * 35,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              /**
               * Header 
               */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.mainGreen,
                      size: scale * 30,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minimumSize: Size.zero,
                    ),
                  ),
                  Text(
                    'Diario personal',
                    style: TextStyle(
                      fontSize: scale * 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mainGreen,
                    ),
                  ),
                ],
              ),

              SizedBox(height: scale * 10),

              Divider(height: 1, color: AppColors.mainGreen),

              SizedBox(height: scale * 10),

              /**
               * Content
               */
              _loading
                  ? CircularProgressIndicator(color: AppColors.mainGreen)
                  : _entries.isEmpty
                  ? Text(
                      'Aún no has escrito ninguna nota. ¡Empieza ya!',
                      style: TextStyle(color: AppColors.darkerGrey),
                      textAlign: TextAlign.center,
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _entries.length,
                      separatorBuilder: (_, __) => SizedBox(height: scale * 10),
                      itemBuilder: (context, index) {
                        final entry = _entries[index];
                        return Container(
                          padding: EdgeInsets.all(scale * 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: BoxBorder.all(color: AppColors.mainGreen)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    entry['entryDate'] ?? ' ',
                                    style: TextStyle(
                                      fontSize: scale * 12,
                                      color: AppColors.mainGreen,
                                    ),
                                  ),
                                  Text(
                                    entry['entryTime'] ?? ' ',
                                    style: TextStyle(
                                      fontSize: scale * 12,
                                      color: AppColors.mainGreen,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: scale * 5),

                              Text(
                                entry['title'] ?? ' ',
                                style: TextStyle(
                                  fontSize: scale * 14,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.darkerGrey,
                                ),
                              ),

                              SizedBox(height: scale * 5),

                              Text(
                                entry['content'] ?? ' ',
                                style: TextStyle(
                                  fontSize: scale * 12,
                                  color: AppColors.darkerGrey,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCreateDialog();
        },
        backgroundColor: AppColors.mainGreen,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
