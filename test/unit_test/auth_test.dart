import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),
  MockSpec<HomeViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late RegisterViewNavigator mockRegisterViewNavigator;
  late HomeViewNavigator mockHomeViewNavigator;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;

  setUp(
    () {
      mockAuthUsecase = MockAuthUseCase();
      mockLoginViewNavigator = MockLoginViewNavigator();
      mockRegisterViewNavigator = MockRegisterViewNavigator();
      mockHomeViewNavigator = MockHomeViewNavigator();
      container = ProviderContainer(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(
              mockLoginViewNavigator,
              mockRegisterViewNavigator,
              mockAuthUsecase,
              mockHomeViewNavigator,
            ),
          )
        ],
      );
    },
  );

  test('check for the initial state in Auth State', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

//Creating a test for login
  test('login test with valid credentials', () async {
    const correctApplicantName = "Ayush";
    const correctPassword = "1234";
    when(mockAuthUsecase.loginApplicant(any, any)).thenAnswer((invocation) {
      final applicantname = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          applicantname == correctApplicantName && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: "Invalid")));
    });

    //Act
    await container
        .read(authViewModelProvider.notifier)
        .loginApplicant("Ayush", "1234");

    final authState = container.read(authViewModelProvider);

    //assert
    expect(authState.error, isNull);
  });

  //Creating a test for register
  test('register test with valid applicant data', () async {
    const correctApplicant = AuthEntity(
      id: '1',
      name: 'Aysuh',
      phone: 'Shrestha',
      email: 'test@gmail.com',
      password: '12345',
    );

    // Arrange
    when(mockAuthUsecase.registerApplicant(any)).thenAnswer((invocation) {
      final applicant = invocation.positionalArguments[0] as AuthEntity;

      return Future.value(applicant.email == correctApplicant.email &&
              applicant.password == correctApplicant.password &&
              applicant.name == correctApplicant.name &&
              applicant.phone == correctApplicant.phone &&
              applicant.email == correctApplicant.email
          ? const Right(true)
          : Left(Failure(error: 'Invalid applicant data')));
    });

    // Act
    await container
        .read(authViewModelProvider.notifier)
        .registerApplicant(correctApplicant);

    final authState = container.read(authViewModelProvider);

    // Assert
    expect(authState.error, isNull);
    expect(authState.isLoading, isFalse);
  });
  //

  // Creating a test for getCurrentApplicant
  test('getCurrentApplicant retrieves data successfully', () async {
    const testApplicant = AuthEntity(
      id: '1',
      name: 'Ayush',
      phone: '1234567890',
      email: 'ayush@example.com',
      password: 'secure1234',
    );

    when(mockAuthUsecase.getCurrentApplicant()).thenAnswer(
      (_) async => const Right(testApplicant),
    );

    // Act
    await container.read(authViewModelProvider.notifier).getCurrentApplicant();

    // Assert
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, isFalse);
    expect(authState.error, isNull);
  });

  tearDown(() {
    container.dispose();
  });
}
