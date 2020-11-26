import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/models/comment_model.dart';
import 'package:facebook_clone_flutter_app/models/post_model.dart';
import 'package:facebook_clone_flutter_app/models/user_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/utils/tools.dart';
import 'package:facebook_clone_flutter_app/widgets/comment.dart';
import 'package:facebook_clone_flutter_app/widgets/custom_editable_text.dart';
import 'package:facebook_clone_flutter_app/widgets/drawer.dart';
import 'package:facebook_clone_flutter_app/widgets/post_bottom_row.dart';
import 'package:facebook_clone_flutter_app/widgets/post_pictures.dart';
import 'package:facebook_clone_flutter_app/widgets/post_reactions.dart';
import 'package:facebook_clone_flutter_app/widgets/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostPage extends StatefulWidget {
  final int index;

  const PostPage({Key key, this.index}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool saved = false;

  PostModel post = new PostModel(
      user: new UserModel(
          name: 'User Name',
          otherName: 'Other Name',
          bio: 'Bio Text 💭',
          verified: true),
      elapsedTime: '20 mins',
      body: 'Click to write your own post text',
      reactionsCount: 1,
      commentsCount: 1,
      shareCount: 1,
      comments: [],
      images: []);

  TextEditingController textControllerPhotosCount =
  new TextEditingController();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  addPostPic({int index}) async {
    Uint8List pic = await Tools.selectPic(context) ?? (await rootBundle.load('assets/images/blank_pic.png'))
        .buffer
        .asUint8List();
    setState(() {
      if (index == null) {
        post.images.add(pic);
      }else{
        post.images[index] = pic;
      }
    });
  }

  initPostPic() async {
    Uint8List pic = (await rootBundle.load('assets/images/blank_pic.png'))
        .buffer
        .asUint8List();
    setState(() {
      post.images.add(pic);
    });
  }

  @override
  void initState() {
    super.initState();
    initPostPic();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void _openOptions(context) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0))),
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (context, bottomSheetSetState) {
            return Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 4.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: MyColors.greyLight,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Verified Account'),
                    trailing: Switch(
                      value: post.user.verified,
                      onChanged: (val) {
                        bottomSheetSetState(() {
                          post.user.verified = val;
                        });
                        setState(() {
                          post.user.verified = val;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('Edit pictures'),
                    trailing: Icon(Icons.edit),
                    onTap: () {
                      Navigator.pop(context);
                      editPictures(post.images);
                    },
                  ),
                ],
              ),
            );
          });
        },
      );
    }

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: HKDrawer.buildDrawer(context),
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/backarrow.svg',
            color: Colors.black,
            width: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
            print('Back Arrow');
          },
        ),
        title: Text(
          'Posts',
          style: MyTextStyles.titleBold,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              print('Search');
            },
          ),
          IconButton(
            tooltip: 'Options',
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              _openOptions(context);
              print('Options');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ProfilePic(
                      onClicked: (pic) {
                        post.user.photo = pic;
                      },
                      user: post.user,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                CustomEditableText(
                                  onSubmited: (val) {
                                    post.user.name = val;
                                  },
                                  title: 'Name',
                                  text: post.user.name,
                                  textStyle: MyTextStyles.fbTitleBold,
                                ),
                                post.user.verified
                                    ? Padding(
                                  padding:
                                  const EdgeInsets.only(left: 4.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/verified_badge.svg',
                                    width: 15.0,
                                  ),
                                )
                                    : SizedBox(),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                CustomEditableText(
                                  onSubmited: (val) {
                                    post.elapsedTime = val;
                                  },
                                  title: 'Elapsed time',
                                  text: post.elapsedTime,
                                  textStyle: MyTextStyles.fbText.apply(
                                    color: MyColors.greyDark,
                                    fontSizeFactor: 0.9,
                                  ),
                                ),
                                Text(
                                  '  • ',
                                  style: MyTextStyles.fbText.apply(
                                    color: MyColors.greyDark,
                                    fontSizeFactor: 0.9,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/globe.svg',
                                    height: 15.0,
                                    color: MyColors.greyDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 12.0),
                        color: Colors.white,
                        child: SvgPicture.asset(
                          'assets/icons/more_hor.svg',
                          color: MyColors.greyDark,
                          width: 20.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomEditableText(
                    onSubmited: (val) {
                      post.body = val;
                    },
                    title: 'Post text',
                    text: post.body,
                    multiline: true,
                    textStyle: MyTextStyles.fbText,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  List<Uint8List> pic = await editPictures(post.images);
                  setState(() {
                    if (pic != null) post.images = pic;
                  });
                },
                child: PostPictures(
                  listImages: post.images,
                  maxHeight: 300.0,
                  morePicsNb: textControllerPhotosCount != null && textControllerPhotosCount.text != '' ? int.parse(textControllerPhotosCount.text) : 0,
                ),
              ),
              Divider(
                height: 1.0,
                indent: 10.0,
                endIndent: 10.0,
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: PostBottomRow(
                  addComment: () async {
                    addComment().then((comment) {
                      if (comment != null) {
                        setState(() {
                          post.comments.add(comment);
                        });
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 5.0),
              Divider(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
                child: PostReactions(
                  onClicked: () {},
                  post: post,
                ),
              ),
              post.comments == null || post.comments.length < 0
                  ? SizedBox()
                  : Column(
                  children: post.comments
                      .map(
                        (item) => Padding(
                      key: Key('keyOfItem' +
                          post.comments.indexOf(item).toString()),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: InkWell(
                        onLongPress: () async {
                          bool ok = await removeDialog();
                          if (ok) {
                            post.comments.remove(item);
                            setState(() {});
                          }
                        },
                        child: CommentWidget(
                          comment: item,
                          showInter: () {},
                        ),
                      ),
                    ),
                  )
                      .toList()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),
        height: 60.0,
        width: Tools.width,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: MyColors.greyLight, width: 2.0))),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.greyLight,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      addComment().then((comment) {
                        if (comment != null) {
                          setState(() {
                            post.comments.add(comment);
                          });
                        }
                      });
                    },
                    child: Text(
                      'Write a comment...',
                      style: TextStyle(color: MyColors.greyDark),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/icons/camera.svg',
                    width: 25.0,
                    color: MyColors.greyDark,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/icons/gif.svg',
                    width: 25.0,
                    color: MyColors.greyDark,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    'assets/icons/smiling_face.svg',
                    width: 25.0,
                    color: MyColors.greyDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> removeDialog() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(
              "Delete Comment?",
              style: MyTextStyles.title.apply(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: Colors.black,
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: Colors.red,
                      ),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            //
                            Navigator.pop(context, true);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<CommentModel> addComment() async {
    CommentModel comment = new CommentModel(
        user: new UserModel(
            name: 'User Name',
            otherName: 'Other Name',
            bio: 'Bio Text 💭',
            verified: false),
        replys: []);
    Uint8List userImage;
    bool verified = false;

    TextEditingController textControllerUserName = new TextEditingController();
    TextEditingController textControllerComment = new TextEditingController();
    TextEditingController textControllerElapsedTime =
    new TextEditingController();
    TextEditingController textControllerReactsCount =
    new TextEditingController();

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Add new comment",
            style: MyTextStyles.title.apply(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          scrollable: true,
          contentPadding: EdgeInsets.all(8.0),
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: MyColors.greyDark,
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(null);
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(100.0),
                        color: MyColors.facebookBlue,
                      ),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(100.0),
                          ),
                          child: new Text(
                            'Ok',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            comment = new CommentModel(
                                user: new UserModel(
                                    name: textControllerUserName.text != ''
                                        ? textControllerUserName.text
                                        : 'User Name',
                                    photo: userImage,
                                    otherName: 'Other Name',
                                    bio: 'Bio Text 💭',
                                    verified: verified),
                                text: textControllerComment.text != ''
                                    ? textControllerComment.text
                                    : 'Click here to edit comment ✏.',
                                elapsedTime:
                                textControllerElapsedTime.text != ''
                                    ? textControllerElapsedTime.text
                                    : '15 m',
                                reactionsCount: int.parse(
                                    textControllerReactsCount.text != ''
                                        ? textControllerReactsCount.text
                                        : '0'),
                                selectedReacts: [
                                  true,
                                  false,
                                  false,
                                  false,
                                  false,
                                  false,
                                  false
                                ],
                                replys: []);
                            Navigator.pop(context, comment);
                          }),
                    ),
                  ),
                ],
              ),
            )
          ],
          content: StatefulBuilder(builder: (context, setState) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                            child: Text(
                              'User pic',
                              style: TextStyle(color: MyColors.accent),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: MyColors.greyLight,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: ProfilePic(
                                user: comment.user,
                                onClicked: (photo) {
                                  userImage = photo;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 5.0, left: 8.0, bottom: 2.0),
                              child: Text(
                                'User Name',
                                style: TextStyle(color: MyColors.accent),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: MyColors.greyLight,
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: textControllerUserName,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    style: MyTextStyles.fbText,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: textControllerUserName.text,
                                      hintStyle: TextStyle(color: Colors.grey),
                                      suffix: Container(
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(100.0),
                                          color: Colors.black,
                                        ),
                                        child: InkWell(
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                            size: 10.0,
                                          ),
                                          onTap: () =>
                                              textControllerUserName.clear(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0, bottom: 2.0),
                            child: Text(
                              'Verified',
                              style: TextStyle(color: MyColors.accent),
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/icons/verified_badge.svg',
                              width: 30.0,
                              color: verified
                                  ? MyColors.accent
                                  : MyColors.greyLight,
                            ),
                            onPressed: () {
                              verified = !verified;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      'Comment text',
                      style: TextStyle(color: MyColors.accent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: MyColors.greyLight,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: textControllerComment,
                          maxLines: 4,
                          keyboardType: TextInputType.multiline,
                          style: MyTextStyles.fbText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textControllerComment.text,
                            hintStyle: TextStyle(color: Colors.grey),
                            suffix: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.black,
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                                onTap: () => textControllerComment.clear(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      'Elapsed time',
                      style: TextStyle(color: MyColors.accent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: MyColors.greyLight,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: textControllerElapsedTime,
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          style: MyTextStyles.fbText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textControllerElapsedTime.text,
                            hintStyle: TextStyle(color: Colors.grey),
                            suffix: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.black,
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                                onTap: () => textControllerElapsedTime.clear(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                    child: Text(
                      'Reacts Count',
                      style: TextStyle(color: MyColors.accent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: MyColors.greyLight,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Center(
                        child: TextField(
                          controller: textControllerReactsCount,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          style: MyTextStyles.fbText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: textControllerReactsCount.text,
                            hintStyle: TextStyle(color: Colors.grey),
                            suffix: Container(
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.black,
                              ),
                              child: InkWell(
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                  size: 10.0,
                                ),
                                onTap: () => textControllerReactsCount.clear(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Future<List<Uint8List>> editPictures(List<Uint8List> listPictures) async {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0))),
        builder: (BuildContext ctx) {
          return StatefulBuilder(builder: (context, bottomSheetSetState) {
            return Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 4.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: MyColors.greyLight,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: listPictures.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return index != listPictures.length
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: Tools.width * 0.3,
                                width: Tools.width * 0.3,
                                child: ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
                                  child: Image.memory(listPictures[index],
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                left: 0.0,
                                child: IconButton(
                                  iconSize: 15.0,
                                  onPressed: () async {
                                    await addPostPic(index: index);
                                    bottomSheetSetState(() {});
                                  },
                                  icon: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.0,
                                right: 0.0,
                                child: IconButton(
                                  iconSize: 15.0,
                                  onPressed: () {
                                    bottomSheetSetState(() {
                                      listPictures.removeAt(index);
                                    });
                                    setState(() {});
                                  },
                                  icon: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 5.0,
                                left: 5.0,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white70,
                                      shape: BoxShape.circle),
                                  child:
                                  Center(child: Text('${index + 1}')),
                                ),
                              ),
                            ],
                          ),
                        )
                            : listPictures.length < 5
                            ? IconButton(
                          onPressed: () async {
                            await addPostPic();
                            bottomSheetSetState(() {});
                          },
                          icon: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              color: MyColors.greyLight,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text('+'),
                            ),
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: Tools.width * 0.3,
                            width: Tools.width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: MyColors.greyLight,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text('+', style: MyTextStyles.fbSubTitleBold.apply(color: MyColors.greyDark)),
                                  Container(
                                    height: 40.0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: MyColors.white,
                                      borderRadius:
                                      BorderRadius.circular(
                                          100.0),
                                    ),
                                    child: TextField(
                                      controller: textControllerPhotosCount,
                                      maxLines: 1,
                                      keyboardType:
                                      TextInputType.number,
                                      style: MyTextStyles.fbText,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: textControllerPhotosCount?.text,
                                        hintStyle: TextStyle(
                                            color: Colors.grey),
                                        suffix: Container(
                                          padding:
                                          EdgeInsets.all(5.0),
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                100.0),
                                            color: Colors.black,
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Icons.clear,
                                              color: Colors.white,
                                              size: 10.0,
                                            ),
                                            onTap: () {
                                              textControllerPhotosCount.clear();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('Photos', style: MyTextStyles.fbSubTitleBold.apply(color: MyColors.greyDark)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
