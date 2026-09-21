import 'package:flutter/material.dart';
import 'package:milktrace/app/theme.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class LiveInfoCard extends StatefulWidget {
  final Color lightColor;
  final double? lightIconSize;
  final double sessionYield, targetAmount, currentFlow, lowFlowRate;
  final String title,
      name,
      sessionYieldUnit,
      targetAmountUnit,
      currentFlowUnit;

  const LiveInfoCard({
    super.key,
    required this.lightColor,
    this.lightIconSize,
    required this.title,
    required this.name,
    required this.sessionYield,
    required this.targetAmount,
    required this.sessionYieldUnit,
    required this.targetAmountUnit,
    required this.currentFlow,
    required this.currentFlowUnit,
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
                    fontSize: 14,
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
                        widget.currentFlow.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.darkBlueColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        widget.currentFlowUnit,
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
            SizedBox(height: 20),
            widget.lowFlowRate > widget.currentFlow
                ? Text(
                    "Düşük Basınç",
                    style: TextStyle(color: AppColors.redColor, fontSize: 14, fontWeight: FontWeight.bold),
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
                      fontSize: 14,
                      color: AppColors.iconGreyColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.sessionYield} ${widget.sessionYieldUnit}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
                      fontSize: 14,
                      color: AppColors.iconGreyColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${widget.targetAmount} ${widget.targetAmountUnit}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
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
