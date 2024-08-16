import 'package:flutter_bloc_project/core/db/database_helper.dart';
import 'package:flutter_bloc_project/cubit/note_cubit.dart';
import 'package:flutter_bloc_project/data/datasource/note_datasource.dart';
import 'package:flutter_bloc_project/data/repository/note_repository_imp.dart';
import 'package:flutter_bloc_project/domain/repository/note_repository.dart';
import 'package:flutter_bloc_project/domain/usecases/add_note_usecase.dart';
import 'package:flutter_bloc_project/domain/usecases/delete_note_usecase.dart';
import 'package:flutter_bloc_project/domain/usecases/load_note_usecase.dart';
import 'package:flutter_bloc_project/domain/usecases/update_note_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void initDependencies() {
  DatabaseHelper databaseHelper = DatabaseHelper();

  getIt
    ..registerLazySingleton(() => databaseHelper)
    ..registerFactory<NoteDatasource>(
      () => NoteDatasourceImpl(
        getIt(),
      ),
    )
    ..registerFactory<NoteRepository>(
      () => NoteRepositoryImpl(
        getIt(),
      ),
    )
    ..registerFactory(
      () => LoadNoteUseCase(
        getIt(),
      ),
    )
    ..registerFactory(
      () => AddNoteUsecase(
        getIt(),
      ),
    )
    ..registerFactory(
      () => UpdateNoteUsecase(
        getIt(),
      ),
    )
    ..registerFactory(
      () => DeleteNoteUsecase(
        getIt(),
      ),
    )
    ..registerLazySingleton(
      () => NoteCubit(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
    );
}
