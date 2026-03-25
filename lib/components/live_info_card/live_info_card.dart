import 'package:flutter/material.dart';
import 'package:milktrace/theme.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class LiveInfoCard extends StatefulWidget {
  final Color lightColor;
  final double? lightIconSize;
  final double sessionYield, targetAmount, currentFlow, lowFlowRate;
  final String title,
      name,
      sessionYieldIndicator,
      targetAmountIndicator,
      currentFlowIndicator;

  const LiveInfoCard({
    super.key,
    required this.lightColor,
    this.lightIconSize,
    required this.title,
    required this.name,
    required this.sessionYield,
    required this.targetAmount,
    required this.sessionYieldIndicator,
    required this.targetAmountIndicator,
    required this.currentFlow,
    required this.currentFlowIndicator,
    required this.lowFlowRate,
  });

  @override
  State<LiveInfoCard> createState() => _LiveInfoCardState();
}

class _LiveInfoCardState extends State<LiveInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.lowFlowRate > widget.currentFlow
            ? AppColors.lightRedColor
            : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Column(
          children: [
            // Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.brightness_1_rounded,
                  color: widget.lowFlowRate > widget.currentFlow
                      ? AppColors.redColor
                      : widget.lightColor,
                  size: widget.lightIconSize ?? 13,
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.lightGreyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.iconGreyColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Akış oranı",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: AppColors.iconGreyColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.currentFlow}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: AppColors.darkBlueColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${widget.currentFlowIndicator}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: AppColors.darkGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            //CircularProgressIndicator(),
            /*LinearProgressIndicator(
              value: 10,
              backgroundColor: Colors.grey,
              minHeight: 2,
            ),*/
            /*            LinearProgressBar(
              maxSteps: 6,
              progressType: ProgressType.linear,
              currentStep: 3,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey,
              borderRadius: BorderRadius.circular(10),
              minHeight: 12,
            ),*/
            /*            CircularPercentIndicator(
              percent: 0.75,
              radius: 60,
              lineWidth: 10,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                '75%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),*/
            /*            GaugeIndicator(
              value: 0.65,
              size: 200,
              strokeWidth: 20,
              valueColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              showValue: true,
              gaugeStyle: GaugeStyle.modern,
            ),*/
            /*            LinearProgressBar(
              maxSteps: 5,
              progressType: ProgressType.dots,
              currentStep: 2,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey,
              dotsActiveSize: 12,
              dotsInactiveSize: 8,
            ),*/
            TitledProgressBar(
              maxSteps: widget.targetAmount.toInt(),
              currentStep: widget.sessionYield.toInt(),
              progressColor: widget.lowFlowRate > widget.currentFlow
                  ? AppColors.redColor
                  : Colors.green,
              backgroundColor: Colors.grey.shade300,
              labelType: LabelType.percentage,
              labelColor: widget.lowFlowRate > widget.currentFlow
                  ? AppColors.darkRedColor
                  : Colors.white,
              labelFontWeight: FontWeight.bold,
              minHeight: 18,
              borderRadius: BorderRadius.circular(12),
              labelSize: 11,
            ),
            /*            GaugeIndicator(
              value: 0.65,
              size: 200,
              strokeWidth: 20,
              backgroundColor: Colors.grey.shade200,
              ranges: [
                GaugeRange(start: 0.0, end: 0.33, color: Colors.green),
                GaugeRange(start: 0.33, end: 0.66, color: Colors.orange),
                GaugeRange(start: 0.66, end: 1.0, color: Colors.red),
              ],
              showNeedle: true,
              needleColor: Colors.black87,
              showMinMax: true,
              minLabel: 'Low',
              maxLabel: 'High',
              showValue: true,
              valueFormatter: (v) {
                if (v < 0.33) return 'Good';
                if (v < 0.66) return 'Normal';
                return 'Alert';
              },
            ),*/
            /*            LinearProgressBar(
              maxSteps: 100,
              progressType: ProgressType.linear,
              currentStep: 65,
              progressGradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.pink],
              ),
              backgroundColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              minHeight: 16,
            ),*/
            /*            LinearProgressBar(
              maxSteps: 100,
              progressType: ProgressType.linear,
              currentStep: 10,
              progressColor: Colors.blue,
              backgroundColor: Colors.grey.shade300,
              animateProgress: true,
              animationDuration: Duration(milliseconds: 500),
              animationCurve: Curves.easeInOut,
            ),*/
            SizedBox(height: 20),
            widget.lowFlowRate > widget.currentFlow
                ? Text(
                    "Düşük basınç. Lütfen kontrol ediniz",
                    style: TextStyle(color: AppColors.redColor, fontSize: 10, fontWeight: FontWeight.bold),
                  )
                : SizedBox(),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Şu an",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.iconGreyColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.sessionYield} ${widget.sessionYieldIndicator}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.darkGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "Hedef",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.iconGreyColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.targetAmount} ${widget.targetAmountIndicator}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppColors.darkGreenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
