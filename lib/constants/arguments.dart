import 'package:findrobe_app/models/post.dart';

class EditCollectionArgs {
  final String itemName;

  EditCollectionArgs({
    required this.itemName
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