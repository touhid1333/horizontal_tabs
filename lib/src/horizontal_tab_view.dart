part of '../horizontal_tabs.dart';

class HorizontalTabView extends StatefulWidget {
  HorizontalTabView._internal({
    this.width,
    this.height,
    this.selectedItem,
    this.itemTitles,
    this.itemAssetImagePath,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    this.foregroundColor,
    this.unselectedForegroundColor,
    this.onTap,
  });

  factory HorizontalTabView.simple({
    required double width,
    required double height,
    required int selectedItem,
    required List<String> itemTitles,
    required List<String> itemAssetImagePath,
    required Color backgroundColor,
    required Color unselectedBackgroundColor,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        width: width,
        height: height,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        backgroundColor: backgroundColor,
        unselectedBackgroundColor: unselectedBackgroundColor,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.simple;

  factory HorizontalTabView.rounded({
    required double height,
    required int selectedItem,
    required List<String> itemTitles,
    required List<String> itemAssetImagePath,
    required Color backgroundColor,
    required Color unselectedBackgroundColor,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        height: height,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        backgroundColor: backgroundColor,
        unselectedBackgroundColor: unselectedBackgroundColor,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.rounded;

  factory HorizontalTabView.basic() =>
      HorizontalTabView._internal().._type = _TabType.basic;

  _TabType _type = _TabType.simple;
  final double? width;
  final double? height;
  final int? selectedItem;
  final List<String>? itemTitles;
  final List<String>? itemAssetImagePath;
  final Color? backgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? foregroundColor;
  final Color? unselectedForegroundColor;
  final Function(int)? onTap;

  @override
  State<HorizontalTabView> createState() => _HorizontalTabViewState();
}

class _HorizontalTabViewState extends State<HorizontalTabView> {
  @override
  Widget build(BuildContext context) {
    return widget._type == _TabType.simple
        ? _HorizontalTabSimple(
            width: widget.width!,
            height: widget.height!,
            selectedItem: widget.selectedItem!,
            itemTitles: widget.itemTitles!,
            itemAssetImagePath: widget.itemAssetImagePath!,
            backgroundColor: widget.backgroundColor!,
            unselectedBackgroundColor: widget.unselectedBackgroundColor!,
            foregroundColor: widget.foregroundColor!,
            unselectedForegroundColor: widget.unselectedForegroundColor!,
            onTap: widget.onTap!)
        : widget._type == _TabType.rounded
            ? _HorizontalTabRounded(
                height: widget.height!,
                selectedItem: widget.selectedItem!,
                itemTitles: widget.itemTitles!,
                itemAssetImagePath: widget.itemAssetImagePath!,
                backgroundColor: widget.backgroundColor!,
                unselectedBackgroundColor: widget.unselectedBackgroundColor!,
                foregroundColor: widget.foregroundColor!,
                unselectedForegroundColor: widget.unselectedForegroundColor!,
                onTap: widget.onTap!)
            : const SizedBox();
  }
}
