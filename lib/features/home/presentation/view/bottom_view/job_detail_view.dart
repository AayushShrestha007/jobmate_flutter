import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/job_view_model.dart';
import 'package:final_assignment/features/home/presentation/widgets/resume_selection_dialog.dart';
import 'package:final_assignment/features/resume/presentation/viewmodel/resume_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobDetailView extends ConsumerStatefulWidget {
  final JobEntity job;

  const JobDetailView({super.key, required this.job});

  @override
  _JobDetailViewState createState() => _JobDetailViewState();
}

class _JobDetailViewState extends ConsumerState<JobDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'http://localhost:5500/employerImage/${widget.job.employer.employerImage}', // Adjust this URL to match your backend's image serving path
                  ),
                  radius: 30,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    widget.job.employer.organizationName,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Work type: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.job.workType),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Skills: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.job.skills),
                ],
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16.0, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Qualifications: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.job.qualification),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final resumeViewModel =
                    ref.read(resumeViewModelProvider.notifier);
                await resumeViewModel.getAllResumes();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ResumeSelectionDialog(
                      resumes: resumeViewModel.state.resumes,
                      onResumeSelected: (selectedResumeId) async {
                        await ref
                            .read(jobViewModelProvider.notifier)
                            .applyToJob(widget.job.id!, selectedResumeId);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              child: const Text('Apply Now'),
            ),
          ],
        ),
      ),
    );
  }
}
