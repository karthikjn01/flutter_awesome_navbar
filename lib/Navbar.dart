import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  Color bg;
  Color ec;
  List<String> elemTags;
  List<Icon> icons;
  int current = 0;
  Function(int) onPressed;

  Navbar(this.bg, this.ec, this.elemTags, this.icons, this.current,
      this.onPressed);

  @override
  _NavbarState createState() =>
      _NavbarState(this.bg, this.ec, this.elemTags, this.icons, this.onPressed);
}

class _NavbarState extends State<Navbar> {
  Color bg;
  Color ec;
  List<String> elemTags;
  List<Icon> icons;

  Function(int) onPressed;
  _NavbarState(this.bg, this.ec, this.elemTags, this.icons, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bg,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getChildren(),
        ));
  }

  List<Widget> _getChildren() {
    List<Widget> ret = [];
    for (int i = 0; i < elemTags.length; i++) {
      ret.add(Expanded(
        child: NavbarElement(
            elemTags[i], icons[i], onPressed, i, widget.current == i, this.ec),
      ));
    }
    return ret;
  }
}

class NavbarElement extends StatefulWidget {
  String tag;
  Icon icon;
  Color color;
  int position;
  bool opened;
  Function(int) press;

  NavbarElement(
      this.tag, this.icon, this.press, this.position, this.opened, this.color);

  @override
  _NavbarElementState createState() => _NavbarElementState();
}

class _NavbarElementState extends State<NavbarElement> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.press(widget.position);
      },
      child: Container(
        height: 75,
        child: Stack(
          children: [
            AnimatedPositioned(
              right: 0,
              left: 0,
              top: widget.opened ? -50 : 0,
              bottom: 0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                  curve: Curves.easeInOut,
                  opacity: widget.opened ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: widget.icon),
            ),
            AnimatedPositioned(
              right: 0,
              left: 0,
              bottom: widget.opened ? 0 : -50,
              top: 0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                curve: Curves.easeInOut,
                opacity: widget.opened ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.tag,
                      style: TextStyle(
                          color: widget.color,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      height: 5,
                      width: 5,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
