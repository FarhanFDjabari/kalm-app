import 'package:bloc/bloc.dart';
import 'package:kalm/data/model/curhat/curhat_model.dart';
import 'package:kalm/data/model/curhat/detail_curhat_model.dart';
import 'package:kalm/data/sources/remote/services/curhat/curhat_service.dart';
import 'package:meta/meta.dart';

part 'curhat_state.dart';

class CurhatCubit extends Cubit<CurhatState> {
  CurhatCubit() : super(CurhatInitial());
  CurhatService curhatService = CurhatService();

  void fetchAllCurhat(int userId) async {
    emit(CurhatLoading());
    try {
      final result = await curhatService.fetchAllCurhat(userId: userId);
      if (result.success) {
        emit(CurhatLoaded(result.data!.curhatans!));
      } else {
        emit(CurhatLoadError("Error: ${result.message}"));
      }
    } catch (error) {
      emit(CurhatLoadError("Error: $error}"));
    }
  }

  void fetchCurhatByCategory(int userId, String category) async {
    emit(CurhatLoading());
    try {
      final result = await curhatService.fetchCurhatByCategory(
          userId: userId, category: category);
      if (result.success) {
        emit(CurhatLoaded(result.data!.curhatans!));
      } else {
        emit(CurhatLoadError("Error: ${result.message}"));
      }
    } catch (error) {
      emit(CurhatLoadError("Error: $error}"));
    }
  }

  void getCurhatDetail(int userId, int curhatId) async {
    emit(CurhatLoading());
    try {
      final result = await curhatService.fetchCurhatById(
          userId: userId, curhatId: curhatId);
      if (result.success) {
        emit(DetailCurhatLoaded(result.data!.curhatan!));
      } else {
        emit(CurhatLoadError("Error: ${result.message}"));
      }
    } catch (error) {
      emit(CurhatLoadError("Error: $error}"));
    }
  }

  void postNewCurhat(
      int userId, bool isAnonymous, String content, String topic) async {
    emit(CurhatLoading());
    try {
      final result = await curhatService.createNewCurhat(
        userId: userId,
        isAnonymous: isAnonymous,
        content: content,
        topic: topic,
      );
      if (result.success) {
        emit(CurhatPosted());
      } else {
        emit(CurhatPostError('Error: ${result.message}'));
      }
    } catch (error) {
      emit(CurhatPostError('Error: $error'));
    }
  }

  void postComment(
      int userId, int curhatId, String content, bool isAnonymous) async {
    emit(CurhatLoading());
    try {
      final result = await curhatService.createNewComment(
        userId: userId,
        isAnonymous: isAnonymous,
        curhatId: curhatId,
        content: content,
      );
      if (result.success) {
        emit(CommentPosted());
      } else {
        emit(CurhatPostError('Error: ${result.message}'));
      }
    } catch (error) {
      emit(CurhatPostError('Error: $error'));
    }
  }
}
