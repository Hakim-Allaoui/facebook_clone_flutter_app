import 'package:facebook_clone_flutter_app/utils/tools.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class TabTitle {
  String title;
  int id;

  TabTitle(this.title, this.id);
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: Text('facebook'),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: Delegate(),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.amber,
                child: Text('Body'),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Text('Header', style: TextStyle(color: Colors.blue),)
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 48.0;

  @override
  // TODO: implement minExtent
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class FbTab {
  final String title;
  final Widget icon;

  const FbTab({this.title, this.icon});
}

const List<FbTab> tabs = <FbTab>[
  FbTab(title: 'Home', icon: Icon(Icons.home)),
  FbTab(title: 'Groups', icon: Icon(Icons.group)),
];

class Fragment extends StatefulWidget {
  final FbTab tab;

  const Fragment({Key key, this.tab}) : super(key: key);

  @override
  _FragmentState createState() => _FragmentState();
}

class _FragmentState extends State<Fragment> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.tab.title),
    );
  }
}
