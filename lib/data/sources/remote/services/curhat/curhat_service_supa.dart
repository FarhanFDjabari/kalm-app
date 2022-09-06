import 'package:flutter/widgets.dart';
import 'package:kalm/data/model/auth/user_model.dart' as userModel;
import 'package:kalm/data/model/curhat/comment_model.dart';
import 'package:kalm/data/model/curhat/create_curhat_model.dart';
import 'package:kalm/data/model/curhat/curhat_like_model.dart';
import 'package:kalm/data/model/curhat/curhat_model.dart';
import 'package:kalm/data/model/curhat/detail_comment_model.dart';
import 'package:kalm/data/model/curhat/detail_curhat_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CurhatServiceSupa {
  final client = Supabase.instance.client;

  Future<List<Curhatan>> fetchAllCurhat({required int userId}) async {
    try {
      final response = await client
          .from('curhats')
          .select('id, content, created_at, is_anonymous')
          .order('created_at')
          .execute();
      if (response.status! >= 200 && response.status! <= 299) {
        final curhatsMapData = response.data as List<dynamic>;
        final curhatsData = await Future.wait<Curhatan>(
          curhatsMapData.map((curhat) async {
            final curhatLike =
                await fetchCurhatLike(curhatId: curhat['id'] as int);
            final userData =
                await fetchUserData(userId: curhat['user_id'] as int);

            return Curhatan(
              id: curhat['id'] as int?,
              content: curhat['content'] as String?,
              createdAt: DateTime.tryParse(curhat['created_at']),
              isAnonymous: curhat['is_anonymous'] as bool?,
              likeCount: curhatLike.length,
              user: userData,
            );
          }),
        );

        return curhatsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<CurhatLike>> fetchCurhatLike({required int curhatId}) async {
    try {
      final response = await client
          .from('curhat_likes')
          .select()
          .eq('curhat_id', curhatId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final curhatLikeMapData = response.data as List<dynamic>;
        final curhatLikeData = curhatLikeMapData.map((curhatLike) {
          return CurhatLike(
            id: curhatLike['id'] as int?,
            userId: curhatLike['user_id'] as String?,
            curhatanId: curhatLike['curhat_id'] as String?,
            createdAt: DateTime.tryParse(curhatLike['created_at']),
          );
        }).toList();

        return curhatLikeData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<int> curhatLike({required int userId, required int curhatId}) async {
    try {
      final response = await client.from('curhat_likes').select().execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final curhatLikesData = response.data as List<dynamic>;

        final isLikeExist = curhatLikesData
            .where(
              (element) =>
                  element['user_id'] == userId &&
                  element['curhat_id'] == curhatId,
            )
            .isNotEmpty;

        if (isLikeExist) {
          await client
              .from('curhat_likes')
              .delete()
              .eq('curhat_id', curhatId)
              .eq('user_id', userId)
              .execute();
          return curhatLikesData.length - 1;
        } else {
          await client.from('curhat_likes').insert({
            'created_at': DateTime.now().toIso8601String(),
            'curhat_id': curhatId,
            'user_id': userId,
          }).execute();
          return curhatLikesData.length + 1;
        }
      }
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  Future<userModel.User> fetchUserData({required int userId}) async {
    try {
      final response = await client
          .from('profiles')
          .select('nama_lengkap, username')
          .eq('id', userId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        // response data: [{id, email, name, username}]
        final userMapData = response.data as List<dynamic>;
        final userData = userModel.User(
          id: int.tryParse(userMapData.first['id']),
          name: userMapData.first['nama_lengkap'] as String?,
          username: userMapData.first['username'] as String?,
        );

        return userData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<PostgrestResponse<dynamic>> fetchCurhatComment(
      {required int curhatId}) async {
    try {
      final response = await client
          .from('comments')
          .select()
          .eq('curhat_id', curhatId)
          .order('created_at')
          .execute();
      if (response.status! >= 200 && response.status! <= 299) {
        return response;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<List<Curhatan>> fetchCurhatByCategory({
    required String category,
    required int userId,
  }) async {
    try {
      final response = await client
          .from('curhats')
          .select('id, content, created_at, is_anonymous')
          .eq('category', category)
          .order('created_at')
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final curhatsMapData = response.data as List<dynamic>;
        final curhatsData =
            await Future.wait<Curhatan>(curhatsMapData.map((curhat) async {
          final curhatLike =
              await fetchCurhatLike(curhatId: curhat['id'] as int);

          final userData =
              await fetchUserData(userId: curhat['user_id'] as int);

          return Curhatan(
            id: curhat['id'] as int?,
            content: curhat['content'] as String?,
            createdAt: DateTime.tryParse(curhat['created_at']),
            isAnonymous: curhat['is_anonymous'] as bool?,
            likeCount: curhatLike.length,
            user: userData,
          );
        }));

        return curhatsData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<DetailCurhatan> fetchCurhatById({
    required int userId,
    required int curhatId,
  }) async {
    try {
      final response = await client
          .from('curhats')
          .select()
          .eq('curhat_id', curhatId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final detailCurhatMapData = response.data as List<dynamic>;

        final curhatLikes = await fetchCurhatLike(curhatId: curhatId);
        final userData = await fetchUserData(
            userId: detailCurhatMapData.first['user_id'] as int);
        final commentsResponse = await fetchCurhatComment(curhatId: curhatId);

        final comments = commentsResponse.data as List<dynamic>;
        final commentData = await Future.wait<DetailComment>(
          comments.map((comment) async {
            final userCommentData =
                await fetchUserData(userId: comment['user_id'] as int);

            return DetailComment(
              id: comment['id'] as int?,
              curhatanId: comment['curhat_id'] as String?,
              userId: comment['user_id'] as String?,
              username: userCommentData.username,
              isAnonymous: comment['is_anonymous'] as bool?,
              content: comment['content'] as String?,
              createdAt: DateTime.parse(comment['created_at'] as String),
            );
          }),
        );

        final List<CurhatLike> curhatLikeData = curhatLikes.map((curhatLike) {
          return CurhatLike(
            id: curhatLike.id,
            curhatanId: curhatLike.curhatanId,
            userId: curhatLike.userId,
            createdAt: curhatLike.createdAt,
          );
        }).toList();

        final detailCurhatData = DetailCurhatan(
          id: detailCurhatMapData.first['id'] as int?,
          category: detailCurhatMapData.first['topic'] as String?,
          content: detailCurhatMapData.first['content'] as String?,
          createdAt: DateTime.tryParse(detailCurhatMapData.first['created_at']),
          isAnonymous: detailCurhatMapData.first['is_anonymous'] as bool?,
          user: userData,
          comments: commentData,
          curhatLike: curhatLikeData,
        );

        return detailCurhatData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<CreateCurhatan> createNewCurhat({
    required int userId,
    required bool isAnonymous,
    required String content,
    required String topic,
  }) async {
    try {
      final response = await client.from('curhats').insert({
        'user_id': userId,
        'created_at': DateTime.now().toIso8601String(),
        'is_anonymous': isAnonymous,
        'content': content,
        'topic': topic,
      }).execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final createCurhatMapData = response.data as List<dynamic>;
        final createCurhatData = CreateCurhatan(
          id: createCurhatMapData.first['id'] as int?,
          userId: createCurhatMapData.first['user_id'] as int?,
          createdAt: DateTime.tryParse(createCurhatMapData.first['created_at']),
          isAnonymous: createCurhatMapData.first['is_anonymous'] as bool?,
          content: createCurhatMapData.first['content'] as String?,
        );
        return createCurhatData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }

  Future<String> deleteCurhat(
      {required int userId, required int curhatId}) async {
    try {
      final response = await client
          .from('curhats')
          .delete()
          .eq('user_id', userId)
          .eq('curhat_id', curhatId)
          .execute();

      if (response.status! >= 200 && response.status! <= 299) {
        return "Postingan telah dihapus";
      }
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  Future<Comment> createNewComment({
    required int userId,
    required int curhatId,
    required String content,
    required bool isAnonymous,
  }) async {
    try {
      final response = await client.from('comments').insert({
        'user_id': userId,
        'created_at': DateTime.now().toIso8601String(),
        'curhat_id': curhatId,
        'content': content,
        'is_anonymous': isAnonymous
      }).execute();

      if (response.status! >= 200 && response.status! <= 299) {
        final commentMapData = response.data as List<dynamic>;
        final commentData = Comment(
          id: commentMapData.first['id'] as int?,
          userId: commentMapData.first['user_id'] as int?,
          content: commentMapData.first['content'] as String?,
          createdAt: DateTime.tryParse(commentMapData.first['createdAt']),
          curhatanId: commentMapData.first['curhat_id'] as int?,
          isAnonymous: commentMapData.first['is_anonymous'] as bool?,
          username: commentMapData.first['user_id'] as String?,
        );
        return commentData;
      }
      print(response.error!.message);
      throw ErrorDescription(response.error!.message);
    } catch (e) {
      print(e.toString());
      throw ErrorDescription(e.toString());
    }
  }
}

final curhatServiceSupa = CurhatServiceSupa();
