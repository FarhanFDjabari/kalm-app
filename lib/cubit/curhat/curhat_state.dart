part of 'curhat_cubit.dart';

@immutable
abstract class CurhatState {}

class CurhatInitial extends CurhatState {}

class CurhatLoaded extends CurhatState {
  final List<Curhatan> curhatanList;

  CurhatLoaded(this.curhatanList);
}

class CurhatLoading extends CurhatState {}

class DetailCurhatLoaded extends CurhatState {
  final DetailCurhatan detailCurhatan;

  DetailCurhatLoaded(this.detailCurhatan);
}

class CurhatPosted extends CurhatState {}

class CommentPosted extends CurhatState {}

class CurhatLoadError extends CurhatState {
  final String errorMessage;

  CurhatLoadError(this.errorMessage);
}

class CurhatPostError extends CurhatState {
  final String errorMessage;

  CurhatPostError(this.errorMessage);
}
