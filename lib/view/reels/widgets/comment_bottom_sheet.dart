import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seen/config/style/colors.dart';
import 'package:seen/controller/reel_controller.dart';
import 'package:seen/core/extension.dart';
import 'package:seen/data/model/reel.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CommentBottomSheet extends StatelessWidget {
  CommentBottomSheet({super.key, required this.reelVideo});
  ReelController controller = Get.find();
  ReelVideo reelVideo;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.backGround,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      height: 50.h(context),
      width: 100.w(context),
      child: Column(
        children: [
          Container(
            height: 20,
          ),
          Container(
            width: 15.w(context),
            height: 3,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            height: 40,
          ),
          Expanded(
            child: Obx(
              () => ListView(
                children: [
                  ...List.generate(
                      20,
                      (index) => CommentWidget(
                          comment: Comment(
                              comment: Faker().person.name(),
                              id: 2,
                              image: Faker().image.image(),
                              userName: Faker().person.name()))),
                  ...controller.comments.map(
                    (e) => CommentWidget(comment: e),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.like(reelVideo.id.toString());
                    },
                    icon: SvgPicture.asset(reelVideo.isLiked
                        ? 'assets/svg/like.svg'
                        : 'assets/svg/like_deactive.svg')),
                Container(
                  height: 40,
                  width: 70.w(context),
                  child: TextField(
                    controller: controller.commentController,
                    decoration: InputDecoration(
                      hintText: 'comment'.tr,
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28)),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      controller.comment(reelVideo.id.toString());
                    },
                    icon: SvgPicture.asset('assets/svg/comment.svg')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    required this.comment,
    super.key,
  });
  final Comment comment;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(comment.image),
        ),
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff303030), Color(0xff191919)],
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(comment.userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    )),
                Text(comment.comment,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
