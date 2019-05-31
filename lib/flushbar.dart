import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'flushbar_route.dart' as route;

const String FLUSHBAR_ROUTE_NAME = "/flushbarRoute";

typedef void FlushbarStatusCallback(FlushbarStatus status);

/// A highly customizable widget so you can notify your user when you fell like he needs a beautiful explanation.
///
/// [title] The title displayed to the user
/// [message] The message displayed to the user.
/// [titleText] Replaces [title]. Although this accepts a [Widget], it is meant to receive [Text] or [RichText]
/// [messageText] Replaces [message]. Although this accepts a [Widget], it is meant to receive [Text] or  [RichText]
/// [icon] You can use any widget here, but I recommend [Icon] or [Image] as indication of what kind of message you are displaying. Other widgets may break the layout
/// [shouldIconPulse] An option to animate the icon (if present). Defaults to true.
/// [aroundPadding] Adds a custom padding to Flushbar
/// [borderRadius] Adds a radius to all corners of Flushbar. Best combined with [aroundPadding]. I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor]
/// [backgroundColor] Flushbar background color. Will be ignored if [backgroundGradient] is not null.
/// [leftBarIndicatorColor] If not null, shows a left vertical bar to better indicate the humor of the notification. It is not possible to use it with a [Form] and I do not recommend using it with [LinearProgressIndicator].
/// [boxShadows] The shadows generated by Flushbar. Leave it null if you don't want a shadow. You can use more than one if you feel the need. Check (this example)[https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/shadows.dart]
/// [backgroundGradient] Flushbar background gradient. Makes [backgroundColor] be ignored.
/// [mainButton] A [FlatButton] widget if you need an action from the user.
/// [duration] How long until Flushbar will hide itself (be dismissed). To make it indefinite, leave it null.
/// [isDismissible] Determines if the user can swipe to dismiss the bar. It is recommended that you set [duration] != null if [isDismissible] == false. If the user swipes Flushbar to dismiss it no value will be returned.
/// [dismissDirection] FlushbarDismissDirection.VERTICAL by default. Can also be [FlushbarDismissDirection.HORIZONTAL] in which case both left and right dismiss are allowed.
/// [flushbarPosition] Flushbar can be based on [FlushbarPosition.TOP] or on [FlushbarPosition.BOTTOM] of your screen. [FlushbarPosition.BOTTOM] is the default.
/// [flushbarStyle] Flushbar can be floating or be grounded to the edge of the screen. If grounded, I do not recommend using [aroundPadding] or [borderRadius]. [FlushbarStyle.FLOATING] is the default
/// [forwardAnimationCurve] The [Curve] animation used when show() is called. [Curves.easeOut] is default.
/// [reverseAnimationCurve] The [Curve] animation used when dismiss() is called. [Curves.fastOutSlowIn] is default.
/// [animationDuration] Use it to speed up or slow down the animation duration
/// [showProgressIndicator] true if you want to show a [LinearProgressIndicator].
/// [progressIndicatorController] An optional [AnimationController] when you want to control the progress of your [LinearProgressIndicator].
/// [progressIndicatorBackgroundColor] a [LinearProgressIndicator] configuration parameter.
/// [progressIndicatorValueColor] a [LinearProgressIndicator] configuration parameter.
/// [overlayBlur] Default is 0.0. If different than 0.0, creates a blurred overlay that prevents the user from interacting with the screen. The greater the value, the greater the blur.
/// [overlayColor] Default is [Colors.transparent]. Only takes effect if [overlayBlur] > 0.0. Make sure you use a color with transparency here e.g. Colors.grey[600].withOpacity(0.2).
/// [userInputForm] A [TextFormField] in case you want a simple user input. Every other widget is ignored if this is not null.
/// [onStatusChanged] a callback for you to listen to the different Flushbar status
class Flushbar<T extends Object> extends StatefulWidget {
  Flushbar(
      {Key key,
      String title,
      String message,
      Widget titleText,
      Widget messageText,
      Widget icon,
      bool shouldIconPulse = true,
      EdgeInsets aroundPadding = const EdgeInsets.all(0.0),
      double borderRadius = 0.0,
      Color backgroundColor = const Color(0xFF303030),
      Color leftBarIndicatorColor,
      List<BoxShadow> boxShadows,
      Gradient backgroundGradient,
      FlatButton mainButton,
      Duration duration,
      bool isDismissible = true,
      FlushbarDismissDirection dismissDirection = FlushbarDismissDirection.VERTICAL,
      bool showProgressIndicator = false,
      AnimationController progressIndicatorController,
      Color progressIndicatorBackgroundColor,
      Animation<Color> progressIndicatorValueColor,
      FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
      FlushbarStyle flushbarStyle = FlushbarStyle.FLOATING,
      Curve forwardAnimationCurve = Curves.easeOut,
      Curve reverseAnimationCurve = Curves.fastOutSlowIn,
      Duration animationDuration = const Duration(seconds: 1),
      FlushbarStatusCallback onStatusChanged,
      double overlayBlur = 0.0,
      Color overlayColor = Colors.transparent,
      Form userInputForm})
      : this.title = title,
        this.message = message,
        this.titleText = titleText,
        this.messageText = messageText,
        this.icon = icon,
        this.shouldIconPulse = shouldIconPulse,
        this.aroundPadding = aroundPadding,
        this.borderRadius = borderRadius,
        this.backgroundColor = backgroundColor,
        this.leftBarIndicatorColor = leftBarIndicatorColor,
        this.boxShadows = boxShadows,
        this.backgroundGradient = backgroundGradient,
        this.mainButton = mainButton,
        this.duration = duration,
        this.isDismissible = isDismissible,
        this.dismissDirection = dismissDirection,
        this.showProgressIndicator = showProgressIndicator,
        this.progressIndicatorController = progressIndicatorController,
        this.progressIndicatorBackgroundColor = progressIndicatorBackgroundColor,
        this.progressIndicatorValueColor = progressIndicatorValueColor,
        this.flushbarPosition = flushbarPosition,
        this.flushbarStyle = flushbarStyle,
        this.forwardAnimationCurve = forwardAnimationCurve,
        this.reverseAnimationCurve = reverseAnimationCurve,
        this.animationDuration = animationDuration,
        this.overlayBlur = overlayBlur,
        this.overlayColor = overlayColor,
        this.userInputForm = userInputForm,
        super(key: key) {
    this.onStatusChanged = onStatusChanged ?? (status) {};
  }

  FlushbarStatusCallback onStatusChanged;
  final String title;
  final String message;
  final Widget titleText;
  final Widget messageText;
  final Color backgroundColor;
  final Color leftBarIndicatorColor;
  final List<BoxShadow> boxShadows;
  final Gradient backgroundGradient;
  final Widget icon;
  final bool shouldIconPulse;
  final FlatButton mainButton;
  final Duration duration;
  final bool showProgressIndicator;
  final AnimationController progressIndicatorController;
  final Color progressIndicatorBackgroundColor;
  final Animation<Color> progressIndicatorValueColor;
  final bool isDismissible;
  final EdgeInsets aroundPadding;
  final double borderRadius;
  final Form userInputForm;
  final FlushbarPosition flushbarPosition;
  final FlushbarDismissDirection dismissDirection;
  final FlushbarStyle flushbarStyle;
  final Curve forwardAnimationCurve;
  final Curve reverseAnimationCurve;
  final Duration animationDuration;
  final double overlayBlur;
  final Color overlayColor;

  route.FlushbarRoute<T> _flushbarRoute;

  /// Show the flushbar. Kicks in [FlushbarStatus.IS_APPEARING] state followed by [FlushbarStatus.SHOWING]
  Future<T> show(BuildContext context) async {
    _flushbarRoute = route.showFlushbar<T>(
      context: context,
      flushbar: this,
    );

    return await Navigator.of(context, rootNavigator: false).push(_flushbarRoute);
  }

  /// Dismisses the flushbar causing is to return a future containing [result].
  /// When this future finishes, it is guaranteed that Flushbar was dismissed.
  Future<T> dismiss([T result]) async {
    // If route was never initialized, do nothing
    if (_flushbarRoute == null) {
      return null;
    }

    if (_flushbarRoute.isCurrent) {
      _flushbarRoute.navigator.pop(result);
      return _flushbarRoute.completed;
    } else if (_flushbarRoute.isActive) {
      // removeRoute is called every time you dismiss a Flushbar that is not the top route.
      // It will not animate back and listeners will not detect FlushbarStatus.IS_HIDING or FlushbarStatus.DISMISSED
      // To avoid this, always make sure that Flushbar is the top route when it is being dismissed
      _flushbarRoute.navigator.removeRoute(_flushbarRoute);
    }

    return null;
  }

  /// Checks if the flushbar is visible
  bool isShowing() {
    return _flushbarRoute?.currentStatus == FlushbarStatus.SHOWING;
  }

  /// Checks if the flushbar is dismissed
  bool isDismissed() {
    return _flushbarRoute?.currentStatus == FlushbarStatus.DISMISSED;
  }

  @override
  State createState() {
    return _FlushbarState<T>();
  }
}

class _FlushbarState<K extends Object> extends State<Flushbar> with TickerProviderStateMixin {
  FlushbarStatus currentStatus;

  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  final Widget _emptyWidget = SizedBox(width: 0.0, height: 0.0);
  final double _initialOpacity = 1.0;
  final double _finalOpacity = 0.4;

  final Duration _pulseAnimationDuration = Duration(seconds: 1);

  bool _isTitlePresent;
  double _messageTopMargin;

  FocusScopeNode _focusNode;
  FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();

    assert(((widget.userInputForm != null || ((widget.message != null && widget.message.isNotEmpty) || widget.messageText != null))),
        "A message is mandatory if you are not using userInputForm. Set either a message or messageText");

    _isTitlePresent = (widget.title != null || widget.titleText != null);
    _messageTopMargin = _isTitlePresent ? 6.0 : 16.0;

    _configureLeftBarFuture();
    _configureProgressIndicatorAnimation();

    if (widget.icon != null && widget.shouldIconPulse) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode.attach(context);
  }

  @override
  void dispose() {
    _fadeController?.dispose();

    widget.progressIndicatorController?.removeListener(_progressListener);
    widget.progressIndicatorController?.dispose();

    _focusAttachment.detach();
    _focusNode.dispose();
    super.dispose();
  }

  final Completer<double> _boxHeightCompleter = Completer<double>();

  void _configureLeftBarFuture() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final keyContext = backgroundBoxKey.currentContext;

        if (keyContext != null) {
          final RenderBox box = keyContext.findRenderObject();
          _boxHeightCompleter.complete(box.size.height);
        }
      },
    );
  }

  void _configurePulseAnimation() {
    _fadeController = AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.linear,
      ),
    );

    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController.forward();
      }
    });

    _fadeController.forward();
  }

  Function _progressListener;

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicator && widget.progressIndicatorController != null) {
      _progressListener = () {
        setState(() {});
      };
      widget.progressIndicatorController.addListener(_progressListener);

      _progressAnimation = CurvedAnimation(curve: Curves.linear, parent: widget.progressIndicatorController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1.0,
      child: Material(
        color: widget.flushbarStyle == FlushbarStyle.FLOATING ? Colors.transparent : widget.backgroundColor,
        child: SafeArea(
          minimum: widget.flushbarPosition == FlushbarPosition.BOTTOM
              ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
              : EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
          bottom: widget.flushbarPosition == FlushbarPosition.BOTTOM,
          top: widget.flushbarPosition == FlushbarPosition.TOP,
          left: false,
          right: false,
          child: _getFlushbar(),
        ),
      ),
    );
  }

  Widget _getFlushbar() {
    return (widget.userInputForm != null) ? _generateInputFlushbar() : _generateFlushbar();
  }

  Widget _generateInputFlushbar() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
        child: FocusScope(
          child: widget.userInputForm,
          node: _focusNode,
          autofocus: true,
        ),
      ),
    );
  }

  CurvedAnimation _progressAnimation;
  GlobalKey backgroundBoxKey = GlobalKey();

  Widget _generateFlushbar() {
    return DecoratedBox(
      key: backgroundBoxKey,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.showProgressIndicator
              ? LinearProgressIndicator(
                  value: widget.progressIndicatorController != null ? _progressAnimation.value : null,
                  backgroundColor: widget.progressIndicatorBackgroundColor,
                  valueColor: widget.progressIndicatorValueColor,
                )
              : _emptyWidget,
          Row(mainAxisSize: MainAxisSize.max, children: _getAppropriateRowLayout()),
        ],
      ),
    );
  }

  List<Widget> _getAppropriateRowLayout() {
    if (widget.icon == null && widget.mainButton == null) {
      return [
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(top: _messageTopMargin, left: 16.0, right: 16.0, bottom: 16.0),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon != null && widget.mainButton == null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 16.0),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(top: _messageTopMargin, left: 4.0, right: 16.0, bottom: 16.0),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon == null && widget.mainButton != null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(top: _messageTopMargin, left: 16.0, right: 8.0, bottom: 16.0),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: _getMainActionButton(),
        ),
      ];
    } else {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(constraints: BoxConstraints.tightFor(width: 42.0), child: _getIcon()),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 8.0),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(top: _messageTopMargin, left: 4.0, right: 8.0, bottom: 16.0),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: _getMainActionButton(),
            ) ??
            _emptyWidget,
      ];
    }
  }

  Widget _buildLeftBarIndicator() {
    if (widget.leftBarIndicatorColor != null) {
      return FutureBuilder(
        future: _boxHeightCompleter.future,
        builder: (BuildContext buildContext, AsyncSnapshot<double> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: widget.leftBarIndicatorColor,
              width: 5.0,
              height: snapshot.data,
            );
          } else {
            return _emptyWidget;
          }
        },
      );
    } else {
      return _emptyWidget;
    }
  }

  Widget _getIcon() {
    if (widget.icon != null && widget.icon is Icon && widget.shouldIconPulse) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.icon,
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return _emptyWidget;
    }
  }

  Widget _getTitleText() {
    return widget.titleText != null
        ? widget.titleText
        : Text(
            widget.title ?? "",
            style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
          );
  }

  Text _getDefaultNotificationText() {
    return Text(
      widget.message ?? "",
      style: TextStyle(fontSize: 14.0, color: Colors.white),
    );
  }

  FlatButton _getMainActionButton() {
    if (widget.mainButton != null) {
      return widget.mainButton;
    } else {
      return null;
    }
  }
}

/// Indicates if flushbar is going to start at the [TOP] or at the [BOTTOM]
enum FlushbarPosition { TOP, BOTTOM }

/// Indicates if flushbar will be attached to the edge of the screen or not
enum FlushbarStyle { FLOATING, GROUNDED }

/// Indicates the direction in which it is possible to dismiss
/// If vertical, dismiss up will be allowed if [FlushbarPosition.TOP]
/// If vertical, dismiss down will be allowed if [FlushbarPosition.BOTTOM]
enum FlushbarDismissDirection { HORIZONTAL, VERTICAL }

/// Indicates the animation status
/// [FlushbarStatus.SHOWING] Flushbar has stopped and the user can see it
/// [FlushbarStatus.DISMISSED] Flushbar has finished its mission and returned any pending values
/// [FlushbarStatus.IS_APPEARING] Flushbar is moving towards [FlushbarStatus.SHOWING]
/// [FlushbarStatus.IS_HIDING] Flushbar is moving towards [] [FlushbarStatus.DISMISSED]
enum FlushbarStatus { SHOWING, DISMISSED, IS_APPEARING, IS_HIDING }
