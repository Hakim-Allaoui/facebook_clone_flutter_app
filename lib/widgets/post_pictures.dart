import 'dart:typed_data';

import 'package:facebook_clone_flutter_app/utils/tools.dart';
import 'package:flutter/material.dart';

class PostPictures extends StatefulWidget {
  final List<Uint8List> listImages;
  final double maxHeight;
  final int morePicsNb;

  const PostPictures(
      {Key key, this.listImages, this.maxHeight = 300.0, this.morePicsNb = 1})
      : super(key: key);

  @override
  _PostPicturesState createState() => _PostPicturesState();
}

class _PostPicturesState extends State<PostPictures> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight,
        minWidth: MediaQuery.of(context).size.width,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: widget.listImages.length <= 4
            ? widget.listImages.length <= 3
                ? widget.listImages.length <= 2
                    ? widget.listImages.length <= 1
                        ? widget.listImages == null ||
                                widget.listImages.length == 0
                            ? SizedBox()
                            : Image.memory(widget.listImages[0],
                                fit: BoxFit.fitWidth)
                        : Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.memory(widget.listImages[0],
                                    fit: BoxFit.cover, width: Tools.width),
                              ),
                              SizedBox(height: 4.0),
                              Expanded(
                                flex: 1,
                                child: Image.memory(widget.listImages[1],
                                    fit: BoxFit.cover, width: Tools.width),
                              )
                            ],
                          ) //2 Pics
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.memory(widget.listImages[0],
                                fit: BoxFit.cover, height: widget.maxHeight),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Image.memory(widget.listImages[1],
                                      fit: BoxFit.cover,
                                      width: Tools.width * 0.5),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Image.memory(widget.listImages[2],
                                      fit: BoxFit.cover,
                                      width: Tools.width * 0.5),
                                ),
                              ],
                            ),
                          )
                        ],
                      ) //3 Pics
                : Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.memory(
                          widget.listImages[0],
                          fit: BoxFit.cover,
                          width: Tools.width,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.memory(
                                widget.listImages[1],
                                fit: BoxFit.cover,
                                width: widget.maxHeight * 0.3,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.memory(
                                widget.listImages[2],
                                fit: BoxFit.cover,
                                width: widget.maxHeight * 0.3,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: Image.memory(
                                widget.listImages[3],
                                fit: BoxFit.cover,
                                width: widget.maxHeight * 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ) //4 Pics//5 Pics
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.memory(
                            widget.listImages[0],
                            fit: BoxFit.cover,
                            width: Tools.width,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.memory(
                            widget.listImages[1],
                            fit: BoxFit.cover,
                            width: Tools.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.memory(
                            widget.listImages[2],
                            fit: BoxFit.cover,
                            width: Tools.width,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.memory(
                            widget.listImages[3],
                            fit: BoxFit.cover,
                            width: Tools.width,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Stack(
                            fit: StackFit.loose,
                            children: [
                              Container(
                                color: Colors.black,
                                child: Opacity(
                                  opacity: widget.morePicsNb == 0 ? 1.0 : 0.5,
                                  child: Image.memory(widget.listImages[4],
                                      fit: BoxFit.cover, width: Tools.width),
                                ),
                              ),
                              widget.morePicsNb == 0 ? SizedBox() : Center(
                                child: Text(
                                  '+${widget.morePicsNb}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), //more than 5 Pics
      ),
    );
  }
}
