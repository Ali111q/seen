import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/reel.dart';

class CommentApi extends ApiHelper<Comment> {
  Future<List<Comment>?> getComments(String id) {
    return super.getItems('/reels-comment?reel_id=$id', Comment.fromJson);
  }
}
