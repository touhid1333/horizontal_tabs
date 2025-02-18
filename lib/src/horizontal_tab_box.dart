part of '../horizontal_tabs.dart';

class _HorizontalTabBox extends StatefulWidget {
  final double width;
  final double height;
  final double strokeHeight;
  final int selectedItem;
  final List<String> itemTitles;
  final List<String>? itemAssetImagePath;
  final List<IconData>? itemIcons;
  final Color foregroundColor;
  final Color unselectedForegroundColor;
  final Function(int) onTap;

  const _HorizontalTabBox(
      {required this.selectedItem,
      required this.onTap,
      required this.width,
      required this.height,
      required this.strokeHeight,
      required this.itemTitles,
      this.itemAssetImagePath,
      this.itemIcons,
      required this.foregroundColor,
      required this.unselectedForegroundColor})
      : assert(height >= 60),
        assert(selectedItem >= 0 && selectedItem < itemTitles.length),
        assert(itemAssetImagePath != null || itemIcons != null),
        assert((itemAssetImagePath != null &&
                itemTitles.length == itemAssetImagePath.length) ||
            (itemIcons != null && itemTitles.length == itemIcons.length));

  @override
  State<_HorizontalTabBox> createState() => _HorizontalTabBoxState();
}

class _HorizontalTabBoxState extends State<_HorizontalTabBox> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double itemWidth = widget.itemTitles.length <= 5
          ? (constraints.maxWidth - ((widget.itemTitles.length - 1) * 5)) /
              widget.itemTitles.length
          : widget.height;
      double totalWidth = widget.itemTitles.length <= 5
          ? constraints.maxWidth
          : (itemWidth * widget.itemTitles.length) +
              ((widget.itemTitles.length - 1) * 5);
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: totalWidth,
          height: widget.height,
          child: Stack(
            children: [
              // -----------------------------------
              // All Tabs
              // -----------------------------------
              ListView.builder(
                itemCount: widget.itemTitles.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isSelected = widget.selectedItem == index;
                  bool isLastItem = (index == (widget.itemTitles.length - 1));
                  return Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve:
                            isSelected ? Curves.slowMiddle : Curves.slowMiddle,
                        height: widget.height,
                        width: itemWidth,
                        margin: EdgeInsets.only(
                          right: isLastItem ? 0 : 5,
                          top: isSelected ? 0 : 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(
                                  isSelected ? 10 : 2, isSelected ? 10 : 2),
                              topRight: Radius.elliptical(
                                  isSelected ? 10 : 2, isSelected ? 10 : 2)),
                          border: Border(
                            left: BorderSide(
                              color: isSelected
                                  ? widget.foregroundColor
                                  : widget.unselectedForegroundColor,
                            ),
                            right: BorderSide(
                              color: isSelected
                                  ? widget.foregroundColor
                                  : widget.unselectedForegroundColor,
                            ),
                            top: BorderSide(
                              color: isSelected
                                  ? widget.foregroundColor
                                  : widget.unselectedForegroundColor,
                            ),
                            bottom: BorderSide.none,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // -----------------------------------
                              // Asset Image
                              // -----------------------------------
                              widget.itemAssetImagePath != null
                                  ? Image.asset(
                                      widget.itemAssetImagePath![index],
                                      height: widget.height * .34,
                                      width: widget.height * .34,
                                      color: isSelected
                                          ? widget.foregroundColor
                                          : widget.unselectedForegroundColor,
                                    )
                                  :
                                  // -----------------------------------
                                  // Icons
                                  // -----------------------------------
                                  widget.itemIcons != null
                                      ? Icon(
                                          widget.itemIcons![index],
                                          size: widget.height * .34,
                                          color: isSelected
                                              ? widget.foregroundColor
                                              : widget
                                                  .unselectedForegroundColor,
                                        )
                                      : Icon(
                                          Icons.all_out_outlined,
                                          size: widget.height * .34,
                                          color: isSelected
                                              ? widget.foregroundColor
                                              : widget
                                                  .unselectedForegroundColor,
                                        ),

                              if (isSelected)
                                Text(
                                  widget.itemTitles[index],
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: widget.foregroundColor,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // -----------------------------------
                      // On Tap
                      // -----------------------------------
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            widget.onTap(index);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CustomPaint(
                  painter: _CutLinePainter(
                    color: widget.foregroundColor,
                    totalWidth: totalWidth,
                    itemWidth: itemWidth,
                    spacing: 5,
                    currentIndex: widget.selectedItem,
                    strokeWidth: widget.strokeHeight,
                  ),
                  size: Size(totalWidth, 0),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _CutLinePainter extends CustomPainter {
  final Color color;
  final double totalWidth;
  final double itemWidth;
  final double spacing;
  final int currentIndex;
  final double strokeWidth;

  _CutLinePainter({
    required this.color,
    required this.totalWidth,
    required this.itemWidth,
    required this.spacing,
    required this.currentIndex,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startPoint = 0;
    double endPoint = totalWidth;
    double cutStartPoint =
        ((currentIndex * itemWidth) + (currentIndex * spacing)) + 1;
    double cutEndPoint = (cutStartPoint + itemWidth) - 2;

    canvas.drawLine(Offset(startPoint, 0), Offset(cutStartPoint, 0), paint);
    canvas.drawLine(Offset(cutEndPoint, 0), Offset(endPoint, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Color darkenColor(Color color, double shadeFactor) {
  return Color.fromRGBO(
    (color.red * (1 - shadeFactor)).round(),
    (color.green * (1 - shadeFactor)).round(),
    (color.blue * (1 - shadeFactor)).round(),
    color.opacity,
  );
}

Color lightenColor(Color color, double tintFactor) {
  return Color.fromRGBO(
    (color.red + (255 - color.red) * tintFactor).round(),
    (color.green + (255 - color.green) * tintFactor).round(),
    (color.blue + (255 - color.blue) * tintFactor).round(),
    color.opacity,
  );
}

/*boxShadow: isTap
? []
: (!widget.inset
? [
BoxShadow(
color: darkenColor(widget.boxShadowColor, 0.3),
offset: const Offset(5, 5),
blurRadius: 10,
spreadRadius: 1,
),
BoxShadow(
color: lightenColor(widget.boxShadowColor, 0.25),
offset: const Offset(-5, -5),
blurRadius: 10,
spreadRadius: 1,
),
]
    : [
BoxShadow(
color: darkenColor(widget.boxShadowColor, 0.3),
offset: const Offset(-5, -5),
blurRadius: 10,
spreadRadius: 1,
),
BoxShadow(
color: lightenColor(widget.boxShadowColor, 0.25),
offset: const Offset(5, 5),
blurRadius: 10,
spreadRadius: 1,
),
])),*/
