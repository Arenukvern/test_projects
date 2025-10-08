import 'package:flutter/material.dart';

enum ScreenType {
  rectangle(width: 917, height: 412),
  square(width: 1280, height: 800);

  const ScreenType({required this.width, required this.height});

  final double width;
  final double height;
}

enum ScaleMode { fitWidth, fitHeight, fitMin, fitMax, fill }

mixin ScreenScaler {
  // Static variables for global state only
  static ScreenType _globalScreenType = ScreenType.rectangle;
  static Size? _globalLastScreenSize;

  // Local variables for each widget
  ScaleMode _localScaleMode = ScaleMode.fitWidth;
  double _localScaleFactor = 1;
  Size? _localLastCalculatedSize;

  // Method to set default ScaleMode (can be overridden in widgets)
  ScaleMode get defaultScaleMode => ScaleMode.fitWidth;

  void setScaleMode(final ScaleMode mode) {
    _localScaleMode = mode;
    _localLastCalculatedSize = null; // Reset for recalculation
  }

  void _checkAndUpdateScaler(final BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    // Update global screen type if size changed
    if (_globalLastScreenSize != screenSize) {
      debugPrint(
        'Screen size changed: ${screenSize.width} x ${screenSize.height}',
      );
      _globalScreenType = _determineScreenType(screenSize);
      _globalLastScreenSize = screenSize;
    }

    // Recalculate local scale factor if needed
    if (_localLastCalculatedSize != screenSize) {
      // If ScaleMode wasn't set explicitly, use defaultScaleMode
      if (_localScaleMode == ScaleMode.fitWidth &&
          defaultScaleMode != ScaleMode.fitWidth) {
        _localScaleMode = defaultScaleMode;
      }
      _calculateScaleFactor(screenSize);
      _localLastCalculatedSize = screenSize;
    }
  }

  void _calculateScaleFactor(final Size screenSize) {
    final referenceSize = _globalScreenType;

    switch (_localScaleMode) {
      case ScaleMode.fitWidth:
        _localScaleFactor = screenSize.width / referenceSize.width;
      case ScaleMode.fitHeight:
        _localScaleFactor = screenSize.height / referenceSize.height;
      case ScaleMode.fitMin:
        final widthScale = screenSize.width / referenceSize.width;
        final heightScale = screenSize.height / referenceSize.height;
        _localScaleFactor = widthScale < heightScale ? widthScale : heightScale;
      case ScaleMode.fitMax:
        final widthScale = screenSize.width / referenceSize.width;
        final heightScale = screenSize.height / referenceSize.height;
        _localScaleFactor = widthScale > heightScale ? widthScale : heightScale;
      case ScaleMode.fill:
        _localScaleFactor = 1.0;
    }
    debugPrint('Scale factor: $_localScaleFactor for mode $_localScaleMode');
  }

  ScreenType _determineScreenType(final Size screenSize) {
    final aspectRatio = screenSize.width / screenSize.height;
    final rectangleRatio =
        ScreenType.rectangle.width / ScreenType.rectangle.height;
    final squareRatio = ScreenType.square.width / ScreenType.square.height;

    debugPrint('Current aspect ratio: $aspectRatio');
    debugPrint('Rectangle ratio (917/412): $rectangleRatio');
    debugPrint('Square ratio (1280/800): $squareRatio');

    final rectangleDiff = (aspectRatio - rectangleRatio).abs();
    final squareDiff = (aspectRatio - squareRatio).abs();

    debugPrint('Rectangle diff: $rectangleDiff');
    debugPrint('Square diff: $squareDiff');

    final result = rectangleDiff < squareDiff
        ? ScreenType.rectangle
        : ScreenType.square;
    debugPrint('Screen type: ${result.name}');
    return result;
  }

  double get scaleFactor {
    _checkAndUpdateScaler(context);
    return _localScaleFactor;
  }

  MediaQueryData? _getMediaQuery() {
    try {
      return MediaQuery.of(context);
    } catch (e) {
      print('Error getting MediaQuery: $e');
      return null;
    }
  }

  BuildContext get context;

  double scaleSize(final double rectangleSize, final double squareSize) {
    _checkAndUpdateScaler(context);
    final targetSize = _globalScreenType == ScreenType.rectangle
        ? rectangleSize
        : squareSize;
    return targetSize * _localScaleFactor;
  }

  double scaleWidth(final double rectangleWidth, final double squareWidth) {
    _checkAndUpdateScaler(context);
    final mediaQuery = _getMediaQuery();
    if (mediaQuery == null) return rectangleWidth;

    final screenWidth = mediaQuery.size.width;
    final referenceWidth = _globalScreenType.width;
    final targetWidth = _globalScreenType == ScreenType.rectangle
        ? rectangleWidth
        : squareWidth;
    return (targetWidth / referenceWidth) * screenWidth;
  }

  double scaleHeight(final double rectangleHeight, final double squareHeight) {
    _checkAndUpdateScaler(context);
    final mediaQuery = _getMediaQuery();
    if (mediaQuery == null) return rectangleHeight;

    final screenHeight = mediaQuery.size.height;
    final referenceHeight = _globalScreenType.height;
    final targetHeight = _globalScreenType == ScreenType.rectangle
        ? rectangleHeight
        : squareHeight;
    return (targetHeight / referenceHeight) * screenHeight;
  }

  EdgeInsets scalePadding(
    final EdgeInsets rectanglePadding,
    final EdgeInsets squarePadding,
  ) {
    _checkAndUpdateScaler(context);
    final targetPadding = _globalScreenType == ScreenType.rectangle
        ? rectanglePadding
        : squarePadding;
    final factor = _localScaleFactor;
    return EdgeInsets.only(
      left: targetPadding.left * factor,
      top: targetPadding.top * factor,
      right: targetPadding.right * factor,
      bottom: targetPadding.bottom * factor,
    );
  }

  Size scaleSize2D(final Size rectangleSize, final Size squareSize) => Size(
    scaleWidth(rectangleSize.width, squareSize.width),
    scaleHeight(rectangleSize.height, squareSize.height),
  );

  double get currentScaleFactor => _localScaleFactor;
  ScreenType get currentScreenType => _globalScreenType;
  ScaleMode get currentScaleMode => _localScaleMode;

  bool get isRectangle => _globalScreenType == ScreenType.rectangle;
  bool get isSquare => _globalScreenType == ScreenType.square;
}

class ScreenScalerBuilder extends StatefulWidget {
  const ScreenScalerBuilder({required this.builder, super.key});
  final Widget Function(BuildContext context, ScreenScaler scaler) builder;

  @override
  State<ScreenScalerBuilder> createState() => _ScreenScalerBuilderState();
}

class _ScreenScalerBuilderState extends State<ScreenScalerBuilder>
    with ScreenScaler {
  @override
  void didUpdateWidget(covariant final ScreenScalerBuilder oldWidget) {
    _checkAndUpdateScaler(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(final BuildContext context) => widget.builder(context, this);
}

typedef ScaledSize = ({double rectangleSize, double squareSize});

extension ScreenScalerExtension on Widget {
  Widget withScaledSizedBox({
    required final ScaledSize scaledSize,
    required final ScaledSize height,
  }) => ScreenScalerBuilder(
    builder: (final context, final scaler) => SizedBox(
      width: scaler.scaleSize(scaledSize.rectangleSize, scaledSize.squareSize),
      height: scaler.scaleSize(scaledSize.rectangleSize, scaledSize.squareSize),
    ),
  );
}
