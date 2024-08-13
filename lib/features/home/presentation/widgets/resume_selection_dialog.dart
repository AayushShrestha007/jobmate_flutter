import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:flutter/material.dart';

class ResumeSelectionDialog extends StatefulWidget {
  final List<ResumeEntity> resumes;
  final Function(String) onResumeSelected;

  const ResumeSelectionDialog({
    super.key,
    required this.resumes,
    required this.onResumeSelected,
  });

  @override
  _ResumeSelectionDialogState createState() => _ResumeSelectionDialogState();
}

class _ResumeSelectionDialogState extends State<ResumeSelectionDialog> {
  String? _selectedResumeId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Select a Resume'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: widget.resumes.isEmpty
          ? const Text('No resumes available. Please create one first.')
          : SingleChildScrollView(
              child: ListBody(
                children: widget.resumes
                    .map(
                      (resume) => RadioListTile<String>(
                        title: Text(resume.resumeTitle),
                        value: resume.id!,
                        groupValue: _selectedResumeId,
                        onChanged: (value) {
                          setState(() {
                            _selectedResumeId = value;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
      actions: <Widget>[
        TextButton(
          onPressed: _selectedResumeId == null
              ? null
              : () {
                  widget.onResumeSelected(_selectedResumeId!);
                  Navigator.of(context).pop();
                },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
