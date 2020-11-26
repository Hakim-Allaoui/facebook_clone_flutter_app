import 'package:facebook_clone_flutter_app/models/reply_model.dart';
import 'package:facebook_clone_flutter_app/utils/theme.dart';
import 'package:facebook_clone_flutter_app/widgets/custom_editable_text.dart';
import 'package:facebook_clone_flutter_app/widgets/profile_pic.dart';
import 'package:facebook_clone_flutter_app/widgets/reply_bottom_row.dart';
import 'package:facebook_clone_flutter_app/widgets/reply_reactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReplyWidget extends StatefulWidget {
  final VoidCallback showInter;
  final ReplyModel reply;

  const ReplyWidget({Key key, this.reply, this.showInter}) : super(key: key);
  @override
  _ReplyWidgetState createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[
            ProfilePic(
              user: widget.reply.user,
              onClicked: (v) {
                if(widget.showInter != null) widget.showInter();
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 16.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: MyColors.greyLight,
                            borderRadius:
                            BorderRadius.circular(
                                15.0),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: 205.0
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    CustomEditableText(
                                      title: 'User Name',
                                      text: widget.reply.user.name,
                                      textStyle: MyTextStyles.fbTitleBold,
                                      onSubmited: (v) {
                                        if(widget.showInter != null) widget.showInter();
                                      },
                                    ),
                                    widget.reply.user.verified ? Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: SvgPicture.asset('assets/icons/verified_badge.svg', width: 12.0,),
                                    ) : SizedBox(),
                                  ],
                                ),
                                CustomEditableText(
                                  title: 'Reply text',
                                  text: widget.reply.text,
                                  multiline: true,
                                  onSubmited: (v) {
                                    if(widget.showInter != null) widget.showInter();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        ReplyBottomRow(
                          reply: widget.reply,
                          react: (bool reacted) {
                            setState(() {
                              if (widget.reply.reactionsCount == 0) {
                                widget.reply.reactionsCount = 1;
                              } else {
                                reacted
                                    ? widget.reply.reactionsCount++
                                    : widget.reply.reactionsCount--;
                              }
                            });
                          },
                        ),
                        ReplyReactions(
                          reply: widget.reply,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
