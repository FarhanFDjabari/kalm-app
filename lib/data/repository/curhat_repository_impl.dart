import 'package:dartz/dartz.dart';
import 'package:kalm/data/sources/remote/error/error_handler.dart';
import 'package:kalm/data/sources/remote/services/curhat/curhat_service.dart';
import 'package:kalm/data/sources/remote/services/environtment.dart';
import 'package:kalm/domain/entity/auth/user_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_like_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_comment_entity.dart';
import 'package:kalm/domain/entity/curhat/detail_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/create_curhat_entity.dart';
import 'package:kalm/domain/entity/curhat/comment_entity.dart';
import 'package:kalm/domain/repository/curhat_repository.dart';
import 'package:supabase/supabase.dart';

class CurhatRepositoryImpl extends CurhatRepository {
  final client = SupabaseClient(
      ConfigEnvironments.getEnvironments(), ConfigEnvironments.getPublicKey());

  @override
  Future<Either<String, CommentEntity>> createComment(
      {required int userId,
      required int curhatId,
      required String content,
      required bool isAnonymous}) async {
    // final client = await curhatClient();
    final response = await client
        .from('curhat_comment')
        .insert({
          'user_id': userId,
          'curhat_id': curhatId,
          'content': content,
          'is_anonymous': isAnonymous,
        })
        .execute()
        .handleError((onError) {
          return Left(onError.toString());
        });

    if (response.status! >= 200 && response.status! <= 299) {
      final commentData = CommentEntity(
        id: response.data[0]['id'],
        userId: response.data[0]['user_id'],
        content: response.data[0]['content'],
        createdAt: response.data[0]['createdAt'],
        curhatanId: response.data[0]['curhat_id'],
        isAnonymous: response.data[0]['is_anonymous'],
        username: response.data[0]['user_id'],
      );
      return Right(commentData);
    } else {
      return Left(response.error!.message);
    }
  }

  @override
  Future<Either<String, CreateCurhatanEntity>> createCurhat(
      {required int userId,
      required bool isAnonymous,
      required String content,
      required String topic}) async {
    // final client = await curhatClient();
    final response = await client
        .from('curhats')
        .insert({
          'user_id': userId,
          'is_anonymous': isAnonymous,
          'content': content,
          'topic': topic,
        })
        .execute()
        .handleError((onError) {
          return Left(onError.toString());
        });

    if (response.status! >= 200 && response.status! <= 299) {
      return Right(response.data!.curhatan!.toEntity());
    } else {
      return Left(response.error!.message);
    }
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhat(
      {required int userId}) async {
    // final client = await curhatClient();
    final response = await client
        .from('curhats')
        .select('id, content, created_at, is_anonymous')
        .eq('user_id', userId)
        .execute()
        .handleError((onError) {
      return Left(onError.toString());
    });
    if (response.status! >= 200 && response.status! <= 299) {
      final List<CurhatanEntity> curhatsData = response.data!.map((e) async {
        final curhatLikeData = await client
            .from('curhat_likes')
            .select()
            .eq('curhat_id', e['id'])
            .execute();
        final userData = await client
            .from('profiles')
            .select('nama_lengkap, username')
            .eq('user_id', userId)
            .execute();
        return CurhatanEntity(
          id: e['id'],
          content: e['content'],
          createdAt: e['created_at'],
          isAnonymous: e['is_anonymous'],
          likeCount: curhatLikeData.count,
          user: UserEntity(
            name: userData.data[0]['nama_lengkap'],
            username: userData.data[0]['username'],
          ),
        );
      }).toList();
      return Right(curhatsData);
    } else {
      return Left(response.error!.message);
    }
  }

  @override
  Future<Either<String, List<CurhatanEntity>>> getAllCurhatByCategory(
      {required int userId, required String category}) async {
    // final client = await curhatClient();
    final response = await client
        .from('curhats')
        .select('id, content, created_at, is_anonymous')
        .eq('user_id', userId)
        .eq('topic', category)
        .execute()
        .handleError((onError) {
      return Left(onError.toString());
    });
    if (response.status! >= 200 && response.status! <= 299) {
      final List<CurhatanEntity> curhatsData = response.data!.map((e) async {
        final curhatLikeData = await client
            .from('curhat_likes')
            .select()
            .eq('curhat_id', e['id'])
            .execute();
        final userData = await client
            .from('profiles')
            .select('nama_lengkap, username')
            .eq('user_id', userId)
            .execute();
        return CurhatanEntity(
          id: e['id'],
          content: e['content'],
          createdAt: e['created_at'],
          isAnonymous: e['is_anonymous'],
          likeCount: curhatLikeData.count,
          user: UserEntity(
            name: userData.data[0]['nama_lengkap'],
            username: userData.data[0]['username'],
          ),
        );
      }).toList();
      return Right(curhatsData);
    } else {
      return Left(response.error!.message);
    }
  }

  @override
  Future<Either<String, DetailCurhatanEntity>> getCurhatDetail(
      {required int userId, required int curhatId}) async {
    // final client = await curhatClient();
    final response = await client
        .from('curhats')
        .select()
        .eq('curhat_id', curhatId)
        .execute()
        .handleError((onError) {
      return Left(onError.toString());
    });
    if (response.status! >= 200 && response.status! <= 299) {
      final userData = await client
          .from('profiles')
          .select('nama_lengkap, username')
          .eq('user_id', userId)
          .execute();
      final curhatLike = await client
          .from('curhat_likes')
          .select()
          .eq('curhat_id', response.data[0]['id'])
          .execute();
      final List<CurhatLikeEntity> curhatLikeData =
          (curhatLike.data! as List<Map<String, dynamic>>).map((e) {
        return CurhatLikeEntity(
          id: e['id'],
          curhatanId: e['curhat_id'],
          userId: e['user_id'],
          createdAt: e['created_at'],
        );
      }).toList();
      final comments = await client
          .from('curhat_comment')
          .select()
          .eq('curhat_id', response.data[0]['id'])
          .execute();
      final commentDataFuture =
          (comments.data! as List<Map<String, dynamic>>).map((e) async {
        final userCommentData = await client
            .from('profiles')
            .select('username')
            .eq('user_id', e['user_id'])
            .execute();
        return DetailCommentEntity(
          id: e['id'],
          curhatanId: e['curhat_id'],
          userId: e['user_id'],
          username: userCommentData.data[0]['username'],
          isAnonymous: e['is_anonymous'],
          content: e['content'],
          createdAt: e['created_at'],
        );
      }).toList();

      final List<DetailCommentEntity> commentData = [];
      commentDataFuture.forEach((element) async {
        commentData.add(await element);
      });
      return Right(DetailCurhatanEntity(
        id: response.data[0]['id'],
        category: response.data[0]['topic'],
        content: response.data[0]['content'],
        createdAt: response.data[0]['created_at'],
        isAnonymous: response.data[0]['is_anonymous'],
        user: UserEntity(
          name: userData.data[0]['nama_lengkap'],
          username: userData.data[0]['username'],
        ),
        comments: commentData,
        curhatLike: curhatLikeData,
      ));
    } else {
      return Left(response.error!.message);
    }
  }
}
