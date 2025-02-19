part of '../horizontal_tabs.dart';

class _HorizontalTabConnected extends StatefulWidget {
  final double width;
  final double height;
  final double strokeHeight;
  final int selectedItem;
  final List<String> itemTitles;
  final List<String>? itemAssetImagePath;
  final List<IconData>? itemIcons;
  final Color barColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color unselectedForegroundColor;
  final Function(int) onTap;

  const _HorizontalTabConnected(
      {required this.width,
      required this.height,
      required this.strokeHeight,
      required this.selectedItem,
      required this.itemTitles,
      this.itemAssetImagePath,
      this.itemIcons,
      required this.foregroundColor,
      required this.unselectedForegroundColor,
      required this.onTap,
      required this.barColor,
      required this.backgroundColor})
      : assert(height >= 60),
        assert(strokeHeight >= 15),
        assert(selectedItem >= 0 && selectedItem < itemTitles.length),
        assert(itemAssetImagePath != null || itemIcons != null),
        assert((itemAssetImagePath != null &&
                itemTitles.length == itemAssetImagePath.length) ||
            (itemIcons != null && itemTitles.length == itemIcons.length));

  @override
  State<_HorizontalTabConnected> createState() =>
      _HorizontalTabConnectedState();
}

class _HorizontalTabConnectedState extends State<_HorizontalTabConnected> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double itemWidth = widget.itemTitles.length <= 5
          ? constraints.maxWidth / widget.itemTitles.length
          : widget.height;
      double totalWidth = widget.itemTitles.length <= 5
          ? constraints.maxWidth
          : (itemWidth * widget.itemTitles.length) +
              ((widget.itemTitles.length + 1) * 10) +
              20;
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: totalWidth,
          height: widget.height,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: (widget.height / 2),
                child: Center(
                  child: CustomPaint(
                    painter: _ConnectedLinePainter(
                      color: widget.barColor,
                      width: widget.itemTitles.length <= 5
                          ? totalWidth
                          : totalWidth - 20,
                      height: widget.strokeHeight,
                    ),
                    size: Size(
                        widget.itemTitles.length <= 5
                            ? totalWidth
                            : totalWidth - 20,
                        0),
                  ),
                ),
              ),
              // -----------------------------------
              // All Tabs
              // -----------------------------------
              ListView.builder(
                itemCount: widget.itemTitles.length,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isSelected = widget.selectedItem == index;
                  return Container(
                    margin: widget.itemTitles.length <= 5
                        ? null
                        : EdgeInsets.only(
                            right: 10,
                            left: index == 0 ? 20 : 0,
                          ),
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: _ConnectedCirclePainter(
                              height: widget.height,
                              width: itemWidth,
                              color: widget.barColor),
                          size: Size(itemWidth, widget.height),
                        ),

                        Positioned.fill(
                            child: Center(
                          child: Container(
                            height: (min(widget.height, itemWidth) - 12),
                            width: (min(widget.height, itemWidth) - 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  (min(widget.height, itemWidth) - 12)),
                              border: Border.all(color: widget.backgroundColor),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.backgroundColor,
                                  blurStyle: BlurStyle.inner,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, -5),
                                ),
                                BoxShadow(
                                  color: widget.backgroundColor,
                                  blurStyle: BlurStyle.inner,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: widget.barColor,
                                  blurStyle: BlurStyle.inner,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(6, 0),
                                ),
                                BoxShadow(
                                  color: widget.barColor,
                                  blurStyle: BlurStyle.inner,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(-6, 0),
                                ),
                              ],
                              color: widget.backgroundColor,
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
                                              : widget
                                                  .unselectedForegroundColor,
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
                        )),
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _ConnectedCirclePainter extends CustomPainter {
  final double height;
  final double width;
  final Color color;

  _ConnectedCirclePainter({
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final centerX = width / 2;
    final centerY = height / 2;
    final radius = min(centerX, centerY);

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ConnectedLinePainter extends CustomPainter {
  final double height;
  final double width;
  final Color color;

  _ConnectedLinePainter({
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = height
      ..style = PaintingStyle.fill;

    canvas.drawLine(const Offset(0, 0), Offset(width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/*class WaterDropPainter extends CustomPainter {
  final Animation<double> sizeAnimation;
  final Animation<double> fallAnimation;

  WaterDropPainter(this.sizeAnimation, this.fallAnimation)
      : super(repaint: sizeAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green.withOpacity(1 - sizeAnimation.value / 20)
      ..style = PaintingStyle.fill;

    Offset dropPosition = Offset(
      size.center(Offset.zero).dx,
      size.center(Offset.zero).dy + fallAnimation.value,
    );

    Path dropPath = Path();
    double radius = sizeAnimation.value;

    // Create a teardrop shape
    dropPath.moveTo(dropPosition.dx, dropPosition.dy - radius); // Top Point
    dropPath.quadraticBezierTo(
        dropPosition.dx + radius, dropPosition.dy, dropPosition.dx, dropPosition.dy + radius);
    dropPath.quadraticBezierTo(
        dropPosition.dx - radius, dropPosition.dy, dropPosition.dx, dropPosition.dy - radius);
    dropPath.close();

    canvas.drawPath(dropPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}*/

/*class WaterDropPainter extends CustomPainter {
  final double fallValue;
  final double sizeValue;

  WaterDropPainter({required this.fallValue, required this.sizeValue});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.green.shade200, Colors.green.shade900],
        center: const Alignment(0, 0.3),
        radius: 1.2,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    double w = size.width * sizeValue; // Scale size dynamically
    double h = size.height * sizeValue;
    double centerX = size.width / 2;



    Path dropPath = Path();

    // Start from the top point
    dropPath.moveTo(centerX, 0);

    // Left side curve
    dropPath.quadraticBezierTo(0, h * 0.3, w * 0.1, h * 0.65);
    dropPath.quadraticBezierTo(w * 0.2, h * 0.9, centerX, h);

    // Right side curve
    dropPath.quadraticBezierTo(w * 0.8, h * 0.9, w * 0.9, h * 0.65);
    dropPath.quadraticBezierTo(w, h * 0.3, centerX, 0);

    dropPath.close();
    canvas.drawPath(dropPath, paint);

    // **Adding Glossy Highlight**
    Paint highlightPaint = Paint()..color = Colors.white.withOpacity(0.4);
    Path highlightPath = Path();

    highlightPath.moveTo(w * 0.3, h * 0.2);
    highlightPath.quadraticBezierTo(w * 0.1, h * 0.4, w * 0.3, h * 0.55);
    highlightPath.quadraticBezierTo(w * 0.4, h * 0.65, w * 0.5, h * 0.7);

    canvas.drawPath(highlightPath, highlightPaint);

    // **Adding Small Droplets**
    Paint smallDropPaint = Paint()..color = Colors.white.withOpacity(0.5);
    canvas.drawCircle(Offset(w * 0.7, h * 0.3), 6, smallDropPaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.5), 4, smallDropPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}*/
