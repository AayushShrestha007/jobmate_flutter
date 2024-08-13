import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/job_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/job_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data/job_entity_data.dart';
import 'job_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<JobUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockJobUseCase mockJobUseCase;
  late ProviderContainer container;
  late List<JobEntity> lstJobs;

  setUp(
    () {
      mockJobUseCase = MockJobUseCase();
      lstJobs = JobTestData.getJobTestData();
      container = ProviderContainer(
        overrides: [
          jobViewModelProvider.overrideWith(
            (ref) => JobViewModel(mockJobUseCase),
          ),
        ],
      );
    },
  );

  test('check job initial state', () async {
    when(mockJobUseCase.getAllJobs(any))
        .thenAnswer((_) => Future.value(Right(lstJobs)));

    // Store the state
    final jobState = container.read(jobViewModelProvider);

    // Check the state
    expect(jobState.isLoading, true);
    expect(jobState.error, isNull);
    expect(jobState.jobs, isEmpty);
  });

  test('test for getting all jobs', () async {
    when(mockJobUseCase.getAllJobs(any))
        .thenAnswer((_) => Future.value(Right(lstJobs)));

    // Get all jobs
    await container.read(jobViewModelProvider.notifier).getAllJobs();

    // Store the state
    final jobState = container.read(jobViewModelProvider);

    // Check the state
    expect(jobState.isLoading, false);
    expect(jobState.error, isNull);
    expect(jobState.jobs, isNotEmpty);
    expect(jobState.jobs.length, lstJobs.length);
  });

  test('getAllJobs should update state correctly on failure', () async {
    const errorMessage = 'Error fetching jobs';
    when(mockJobUseCase.getAllJobs(any))
        .thenAnswer((_) => Future.value(Left(Failure(error: errorMessage))));

    // Get all jobs
    await container.read(jobViewModelProvider.notifier).getAllJobs();

    // Store the state
    final jobState = container.read(jobViewModelProvider);

    // Check the state
    expect(jobState.isLoading, false);
    expect(jobState.error, errorMessage);
    expect(jobState.jobs, isEmpty);
  });

  tearDown(() {
    container.dispose();
  });
}
