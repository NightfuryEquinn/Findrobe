import 'package:findrobe_app/models/clothing.dart';
import 'package:findrobe_app/models/post.dart';
import 'package:findrobe_app/models/user.dart';

class EditCollectionArgs {
  final FindrobeClothing clothing;

  EditCollectionArgs({
    required this.clothing
  });
}

class PostrobeSingleArgs {
  final FindrobePost post;

  PostrobeSingleArgs({
    required this.post
  });
}

class ViewUserArgs {
  final String userId;

  ViewUserArgs({
    required this.userId
  });
}

class FollowersArgs {
  final List<FindrobeUser> followers;

  FollowersArgs({
    required this.followers
  });
}

class CollectionSingleArgs {
  final String category;

  CollectionSingleArgs({
    required this.category
  });
}