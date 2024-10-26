import 'package:findrobe_app/theme/app_colors.dart';
import 'package:findrobe_app/theme/app_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AdminCharts extends StatelessWidget {
  final Map<String, int> graphData;

  const AdminCharts({
    super.key,
    required this.graphData,
  });

  @override
  Widget build(BuildContext context) {
    double maxY = graphData.values.isNotEmpty ? graphData.values.reduce((a, b) => a > b ? a : b).toDouble() : 45.0;

    final monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    final List<BarChartGroupData> barGroups = [];
    final Set<String> displayedMonths = {};

    for (var entry in graphData.entries) {
      final yearMonth = entry.key.split("-");
      final year = yearMonth[0];
      final month = int.parse(yearMonth[1]);

      final displayKey = "$month-$year";
      if (!displayedMonths.contains(displayKey)) {
        displayedMonths.add(displayKey);

        barGroups.add(
          BarChartGroupData(
            x: month,
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(), 
                gradient: const LinearGradient(
                  colors: [AppColors.beige, AppColors.overlayBeige],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight
                ),
                width: 15,
                borderRadius: BorderRadius.circular(5.0),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY + 5.0,
                  color: AppColors.overlayBlack
                )
              )
            ]
          )
        );
      }
    }

    return Center(
      child: Container(
        height: 350,
        padding: const EdgeInsets.only(
          top: 30.0,
          right: 30.0,
          left: 5.0,
          bottom: 5.0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.overlayBlack
        ),
        child: BarChart(
          swapAnimationCurve: Curves.fastEaseInToSlowEaseOut,
          swapAnimationDuration: const Duration(milliseconds: 1000),
          BarChartData(
            alignment: BarChartAlignment.spaceEvenly,
            minY: 0,
            maxY: maxY + 5.0,
            barGroups: barGroups,
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                )
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                )
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true, 
                  reservedSize: 40,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "${value.toInt()}", 
                        style: AppFonts.forum12
                      )
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final monthYear = graphData.keys
                      .firstWhere(
                        (key) => key.endsWith("-${value.toInt().toString().padLeft(2, '0')}"),
                        orElse: () => "0-0"
                      )
                      .split("-");
                    final year = monthYear[0];
                    final monthIndex = value.toInt() - 1;

                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "${monthNames[monthIndex]} $year", 
                        style: AppFonts.forum12
                      )
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (_) {
                return const FlLine(
                  strokeWidth: 1.0,
                  color: AppColors.overlayBeige
                );
              },
              drawVerticalLine: false
            ),
            borderData: FlBorderData(
              show: false
            ),
          )
        )
      )
    );
  }
}