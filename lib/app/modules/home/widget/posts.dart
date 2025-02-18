import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:here_now/app/utils/share_util.dart';
import 'package:here_now/app/utils/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class Posts extends StatelessWidget {
  final String userName;
  final String locationAndTime;
  final String postDescription;
  final String postImage;
  final String coordinates;
  final String likes;
  final int comments;
  final VoidCallback? onRate;
  final VoidCallback? onComment;
  final String userAvatar;
  final String starIcon;
  final String commentIcon;
  final String thumbIcon;
  Posts({
    Key? key,
    this.userName = "John Doe",
    this.locationAndTime = "New York, 21/07/23 18:53",
    this.postDescription =
        "Donec eleifend hendrerit purus et dignissim. Nunc lacinia lorem ut eros scelerisque, quis semper felis accumsan. Proin tempus dolor ex, at convallis mauris sollicitudin sit amet.",
    this.postImage = "",
    this.coordinates = "41.9028° N 12.4964° E",
    this.likes = "555",
    this.comments = 72,
    this.onRate,
    this.onComment,
    this.userAvatar = "assets/images/person.png",
    this.starIcon = "assets/images/star.png",
    this.commentIcon = "assets/images/comment.png",
    this.thumbIcon = "assets/images/thumb.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Post image is ${postImage == "" || postImage == "null"} $postImage");
    return Container(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: userAvatar.contains("https")
                      ? NetworkImage(userAvatar)
                      : AssetImage(userAvatar) as ImageProvider,
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    userName,
                    style: AppStyle.openSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // const Spacer(),
                // IconButton(
                //   icon: Icon(Icons.share, color: AppColors.appColor),
                //   onPressed: _sharePost,
                // ),
              ],
            ),
            Text(
              locationAndTime,
              style: AppStyle.openSans(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            ReadMoreText(
              style: AppStyle.openSans(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
              postDescription,
              trimMode: TrimMode.Line,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              moreStyle: AppStyle.openSans(
                color: AppColors.appColor,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            GestureDetector(
              onTap: () {
                log("Post Image is $postImage");
                Get.toNamed(Routes.fullScreenImageView, arguments: postImage);
              },
              child: Container(
                height: MediaQuery.of(context).size.height /1.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: postImage.isNotEmpty && postImage != "null"
                        ? NetworkImage(postImage)
                        : AssetImage(Images.posts) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        coordinates,
                        style: AppStyle.openSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Image.asset(
                      thumbIcon,
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  likes.toString(),
                  style: AppStyle.openSans(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                InkWell(
                  onTap: onRate,
                  child: Image.asset(
                    starIcon,
                    height: 30,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: onComment,
                  child: Image.asset(
                    commentIcon,
                    height: 30,
                    width: 30,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  comments.toString(),
                  style: AppStyle.openSans(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  width: Get.height * 0.01,
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.black),
                  onPressed: () {
                    ShareUtil.sharePost(
                        postImageUrl: postImage,
                        userName: userName,
                        postDescription: postDescription);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
