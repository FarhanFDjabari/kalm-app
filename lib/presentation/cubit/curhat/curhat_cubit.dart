import 'package:bloc/bloc.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';
import 'package:kalm/domain/usecases/curhat/create_comment.dart';
import 'package:kalm/domain/usecases/curhat/create_curhat.dart';
import 'package:kalm/domain/usecases/curhat/get_all_curhat.dart';
import 'package:kalm/domain/usecases/curhat/get_all_curhat_by_category.dart';
import 'package:kalm/domain/usecases/curhat/get_curhat_detail.dart';
import 'package:meta/meta.dart';

part 'curhat_state.dart';

class CurhatCubit extends Cubit<CurhatState> {
  CurhatCubit({
    required this.createComment,
    required this.createCurhat,
    required this.getAllCurhat,
    required this.getAllCurhatByCategory,
    required this.getCurhatDetailUseCase,
  }) : super(CurhatInitial());

  final CreateComment createComment;
  final CreateCurhat createCurhat;
  final GetAllCurhat getAllCurhat;
  final GetAllCurhatByCategory getAllCurhatByCategory;
  final GetCurhatDetail getCurhatDetailUseCase;

  void fetchAllCurhat(int userId) async {
    emit(CurhatLoading());
    try {
      final result = await getAllCurhat.execute(userId: userId);

      result.fold(
        (l) => emit(CurhatLoadError("Error: $l}")),
        (r) => emit(CurhatLoaded(r)),
      );
    } catch (error) {
      emit(CurhatLoadError("Error: $error}"));
    }
  }

  void fetchCurhatByCategory(int userId, String category) async {
    emit(CurhatLoading());
    try {
      final result = await getAllCurhatByCategory.execute(
          userId: userId, category: category);

      result.fold(
        (l) => emit(CurhatLoadError("Error: $l}")),
        (r) => emit(CurhatLoaded(r)),
      );
    } catch (error) {
      emit(CurhatLoadError("Error: $error}"));
    }
  }

  void getCurhatDetail(int userId, int curhatId) async {
    emit(CurhatLoading());
    try {
      final result = await getCurhatDetailUseCase.execute(
          userId: userId, curhatId: curhatId);

      result.fold(
        (l) => emit(CurhatLoadError("Error: $l")),
        (r) => emit(DetailCurhatLoaded(r)),
      );
    } catch (error) {
      emit(CurhatLoadError("Error: $error}"));
    }
  }

  void postNewCurhat(
      int userId, bool isAnonymous, String content, String topic) async {
    emit(CurhatLoading());
    try {
      final result = await createCurhat.execute(
        userId: userId,
        isAnonymous: isAnonymous,
        content: content,
        topic: topic,
      );

      result.fold(
        (l) => emit(CurhatPostError('Error: $l')),
        (r) => emit(CurhatPosted()),
      );
    } catch (error) {
      emit(CurhatPostError('Error: $error'));
    }
  }

  void postComment(
      int userId, int curhatId, String content, bool isAnonymous) async {
    emit(CurhatLoading());
    try {
      final result = await createComment.execute(
        userId: userId,
        isAnonymous: isAnonymous,
        curhatId: curhatId,
        content: content,
      );

      result.fold(
        (l) => emit(CurhatPostError('Error: $l')),
        (r) => emit(CommentPosted()),
      );
    } catch (error) {
      emit(CurhatPostError('Error: $error'));
    }
  }
}
