import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';

class ResumeState extends Equatable {
  final bool isLoading;
  final List<ResumeEntity> resumes;
  final String? error;
  final bool hasReachedMax;
  final int page;
  final String? pdfPath;

  const ResumeState(
      {required this.isLoading,
      required this.resumes,
      this.error,
      required this.hasReachedMax,
      required this.page,
      this.pdfPath});

  factory ResumeState.initial() {
    return const ResumeState(
      isLoading: false,
      resumes: [],
      error: null,
      hasReachedMax: false,
      page: 0,
    );
  }

  ResumeState copyWith({
    bool? isLoading,
    List<ResumeEntity>? resumes,
    String? error,
    bool? hasReachedMax,
    int? page,
    String? pdfPath,
  }) {
    return ResumeState(
        isLoading: isLoading ?? this.isLoading,
        resumes: resumes ?? this.resumes,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page,
        pdfPath: pdfPath ?? this.pdfPath);
  }

  @override
  List<Object?> get props => [isLoading, resumes, error, hasReachedMax, page];

  @override
  String toString() =>
      'ResumeState(isLoading: $isLoading, resumes: $resumes, error: $error, hasReachedMax: $hasReachedMax, page: $page)';
}
