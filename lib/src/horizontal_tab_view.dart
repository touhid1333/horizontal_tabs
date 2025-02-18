part of '../horizontal_tabs.dart';

class HorizontalTabView extends StatefulWidget {
  HorizontalTabView._internal({
    this.width,
    this.height,
    this.strokeHeight,
    this.selectedItem,
    this.itemTitles,
    this.itemAssetImagePath,
    this.itemIcons,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    this.foregroundColor,
    this.unselectedForegroundColor,
    this.onTap,
  });

  factory HorizontalTabView.basic() =>
      HorizontalTabView._internal().._type = _TabType.basic;

  factory HorizontalTabView.simple({
    required double width,
    required double height,
    required int selectedItem,
    required List<String> itemTitles,
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
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
        itemIcons: itemIcons,
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
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
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
        itemIcons: itemIcons,
        backgroundColor: backgroundColor,
        unselectedBackgroundColor: unselectedBackgroundColor,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.rounded;

  factory HorizontalTabView.box({
    required double width,
    required double height,
    required double strokeHeight,
    required int selectedItem,
    required List<String> itemTitles,
    List<String>? itemAssetImagePath,
    List<IconData>? itemIcons,
    required Color foregroundColor,
    required Color unselectedForegroundColor,
    required Function(int) onTap,
  }) =>
      HorizontalTabView._internal(
        width: width,
        height: height,
        strokeHeight: strokeHeight,
        selectedItem: selectedItem,
        itemTitles: itemTitles,
        itemAssetImagePath: itemAssetImagePath,
        itemIcons: itemIcons,
        foregroundColor: foregroundColor,
        unselectedForegroundColor: unselectedForegroundColor,
        onTap: onTap,
      ).._type = _TabType.box;

  _TabType _type = _TabType.simple;
  final double? width;
  final double? height;
  final double? strokeHeight;
  final int? selectedItem;
  final List<String>? itemTitles;
  final List<String>? itemAssetImagePath;
  final List<IconData>? itemIcons;
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
            itemAssetImagePath: widget.itemAssetImagePath,
            itemIcons: widget.itemIcons,
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
                itemAssetImagePath: widget.itemAssetImagePath,
                itemIcons: widget.itemIcons,
                backgroundColor: widget.backgroundColor!,
                unselectedBackgroundColor: widget.unselectedBackgroundColor!,
                foregroundColor: widget.foregroundColor!,
                unselectedForegroundColor: widget.unselectedForegroundColor!,
                onTap: widget.onTap!)
            : widget._type == _TabType.box
                ? _HorizontalTabBox(
                    width: widget.width!,
                    height: widget.height!,
                    strokeHeight: widget.strokeHeight!,
                    selectedItem: widget.selectedItem!,
                    itemTitles: widget.itemTitles!,
                    itemAssetImagePath: widget.itemAssetImagePath,
                    itemIcons: widget.itemIcons,
                    foregroundColor: widget.foregroundColor!,
                    unselectedForegroundColor:
                        widget.unselectedForegroundColor!,
                    onTap: widget.onTap!,
                  )
                : const SizedBox();
  }
}
