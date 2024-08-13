import 'dart:io';

import 'package:dio/dio.dart';
import 'package:final_assignment/features/resume/presentation/viewmodel/resume_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ResumeListView extends ConsumerStatefulWidget {
  const ResumeListView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResumeListViewState();
}

class _ResumeListViewState extends ConsumerState<ResumeListView> {
  @override
  void initState() {
    super.initState();
    // Fetch the resumes when the view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(resumeViewModelProvider.notifier).getAllResumes();
    });
  }

  Future<String> _downloadFile(String url) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(path.join(tempDir.path, path.basename(url)));
      final response = await Dio().download(url, tempFile.path);
      if (response.statusCode == 200) {
        return tempFile.path;
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      throw Exception('Error downloading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final resumeState = ref.watch(resumeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume List"),
      ),
      body: resumeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : resumeState.resumes.isEmpty
              ? const Center(
                  child: Text(
                    'No resumes created yet',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: resumeState.resumes.length,
                  itemBuilder: (context, index) {
                    final resume = resumeState.resumes[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resume.resumeTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              if (resume.fileUrl == null ||
                                  resume.fileUrl!.isEmpty) {
                                // Check if the fileUrl is valid
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Invalid file URL'),
                                  ),
                                );
                              } else {
                                try {
                                  final filePath = await _downloadFile(
                                      'http://localhost:5500${resume.fileUrl}');
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: SizedBox(
                                        height: 500,
                                        width: 400,
                                        child: PDFView(
                                          filePath: filePath,
                                          onError: (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Error loading PDF: $error'),
                                              ),
                                            );
                                          },
                                          onRender: (pages) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'PDF loaded successfully'),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Error downloading file: $e'),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text("View Resume"),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(thickness: 1),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(resumeViewModelProvider.notifier).openResumeBuilderView();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
