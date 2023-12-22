import 'dart:async';
import 'package:flutter/material.dart';

enum TimerState {
  cooldownTimerState,
  cooldownTimerCompletedState,
  initialState,
  pausedTimer,
  timerCompletedState,
}

class WOICountdowns extends StatefulWidget {
  const WOICountdowns({
    this.timerSize = 200,
    this.timerBackgroundColor = Colors.lightBlue,
    this.timerFillColor = Colors.orange,
    this.coolDownTimerColor = Colors.blueGrey,
    this.cooldownTimerSize = 200,
    this.initialCooldownTimerCenter = const Icon(
      Icons.play_arrow_outlined,
      size: 100,
    ),
    this.cooldownTimerBorderRadius = 200,
    this.coolDownTimerValue,
    this.coolDownTimerTextStyle,
    this.pausedTimerCenterWidget = const Icon(
      Icons.pause,
      size: 100,
    ),
    this.timerCompletionCenterWidget = const Icon(
      Icons.celebration,
      size: 100,
    ),
    required this.timeInSeconds,
    super.key,
  });

  final int? coolDownTimerValue;
  final double timeInSeconds;
  final double timerSize;
  final Color timerBackgroundColor;
  final Color timerFillColor;
  final Color coolDownTimerColor;
  final double cooldownTimerSize;
  final Widget initialCooldownTimerCenter;
  final Widget pausedTimerCenterWidget;
  final Widget timerCompletionCenterWidget;
  final double cooldownTimerBorderRadius;
  final TextStyle? coolDownTimerTextStyle;

  @override
  State<WOICountdowns> createState() => _WOICountdownsState();
}

class _WOICountdownsState extends State<WOICountdowns> {
  late int cooldownTimer;
  bool cooldownComplete = false;
  TimerState timerState = TimerState.initialState;
  double progressValue = 0;

  @override
  void initState() {
    cooldownTimer = widget.coolDownTimerValue ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return timerWidget();
  }

  Widget timerWidget() {
    if (timerState == TimerState.initialState) {
      return GestureDetector(
        onTap: () {
          if (cooldownTimer == 0) {
            timerState = TimerState.cooldownTimerCompletedState;
            setState(() {});
            Timer.periodic(const Duration(seconds: 1), (timer) {
              if (timerState == TimerState.pausedTimer) {
                timer.cancel();
                return;
              }
              if (progressValue >= 1) {
                timer.cancel();
                timerState = TimerState.timerCompletedState;
                setState(() {});
              }
              progressValue += (1 / widget.timeInSeconds);
              setState(() {});
            });
          }
          if (cooldownTimer != 0) {
            timerState = TimerState.cooldownTimerState;
            setState(() {});

            Timer.periodic(const Duration(seconds: 1), (timer) {
              if (timerState == TimerState.initialState) {
                timer.cancel();
                return;
              }
              if (cooldownTimer == 0) {
                timerState = TimerState.cooldownTimerCompletedState;
                if (timerState == TimerState.cooldownTimerCompletedState) {
                  timer.cancel();
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (timerState == TimerState.pausedTimer) {
                      timer.cancel();
                      return;
                    }
                    if (progressValue >= 1) {
                      timer.cancel();
                      timerState = TimerState.timerCompletedState;
                      setState(() {});
                    }
                    progressValue += (1 / widget.timeInSeconds);
                    setState(() {});
                  });
                }
                setState(() {});
              }
              cooldownTimer--;
              setState(() {});
            });
          }
        },
        child: Container(
          height: widget.cooldownTimerSize,
          width: widget.cooldownTimerSize,
          decoration: BoxDecoration(
            color: widget.coolDownTimerColor,
            borderRadius:
                BorderRadius.circular(widget.cooldownTimerBorderRadius),
          ),
          child: Center(
            child: widget.initialCooldownTimerCenter,
          ),
        ),
      );
    }
    if (timerState == TimerState.cooldownTimerState) {
      return GestureDetector(
        onTap: () {
          timerState = TimerState.initialState;
          cooldownTimer = widget.coolDownTimerValue ?? 0;
          setState(() {});
        },
        child: Container(
          height: widget.cooldownTimerSize,
          width: widget.cooldownTimerSize,
          decoration: BoxDecoration(
            color: widget.coolDownTimerColor,
            borderRadius:
                BorderRadius.circular(widget.cooldownTimerBorderRadius),
          ),
          child: Center(
            child: Text(
              cooldownTimer.toString(),
              style: widget.coolDownTimerTextStyle,
            ),
          ),
        ),
      );
    }
    if (timerState == TimerState.cooldownTimerCompletedState) {
      return GestureDetector(
        onTap: () {
          timerState = TimerState.pausedTimer;
          setState(() {});
        },
        child: SizedBox(
          height: widget.timerSize,
          width: widget.timerSize,
          child: CircularProgressIndicator(
            strokeWidth: 15,
            value: progressValue,
            backgroundColor: widget.timerBackgroundColor,
            color: widget.timerFillColor,
            strokeCap: StrokeCap.round,
          ),
        ),
      );
    }
    if (timerState == TimerState.pausedTimer) {
      return GestureDetector(
        onTap: () {
          timerState = TimerState.cooldownTimerCompletedState;
          setState(() {});
          Timer.periodic(const Duration(seconds: 1), (timer) {
            if (timerState == TimerState.pausedTimer) {
              timer.cancel();
              return;
            }
            if (progressValue >= 1) {
              timer.cancel();
              timerState = TimerState.timerCompletedState;
              setState(() {});
            }
            progressValue += (1 / widget.timeInSeconds);
            setState(() {});
          });
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: widget.timerSize,
              width: widget.timerSize,
              child: CircularProgressIndicator(
                strokeWidth: 15,
                value: progressValue,
                backgroundColor: widget.timerBackgroundColor,
                color: widget.timerFillColor,
                strokeCap: StrokeCap.round,
              ),
            ),
            widget.pausedTimerCenterWidget,
          ],
        ),
      );
    }
    if (timerState == TimerState.timerCompletedState) {
      return Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: widget.timerSize,
            width: widget.timerSize,
            child: CircularProgressIndicator(
              strokeWidth: 15,
              value: progressValue,
              backgroundColor: widget.timerBackgroundColor,
              color: widget.timerFillColor,
              strokeCap: StrokeCap.round,
            ),
          ),
          widget.timerCompletionCenterWidget,
        ],
      );
    }
    return SizedBox(
      height: widget.timerSize,
      width: widget.timerSize,
      child: CircularProgressIndicator(
        strokeWidth: 15,
        value: progressValue,
        backgroundColor: widget.timerBackgroundColor,
        color: widget.timerFillColor,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
