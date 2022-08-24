import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kalm/domain/entity/mood_tracker/mood_tracker_entity.dart';
import 'package:kalm/styles/kalm_theme.dart';

class KalmMoodGraph extends StatefulWidget {
  final List<MoodTrackerEntity> graphData;

  KalmMoodGraph({required this.graphData});

  @override
  _KalmMoodGraphState createState() => _KalmMoodGraphState();
}

class _KalmMoodGraphState extends State<KalmMoodGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: tertiaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: LineChart(
          LineChartData(
            minX: 0,
            minY: 0,
            maxX: 6,
            maxY: 2,
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 5,
                  getTitlesWidget: (value, meta) {
                    return const Text('');
                  },
                ),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 5,
                  getTitlesWidget: (value, meta) {
                    return const Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 35,
                  // getTextStyles: (_, value) {
                  //   return kalmOfflineTheme.textTheme.overline!
                  //       .apply(color: secondaryText, fontSizeFactor: 1.1);
                  // },
                  getTitlesWidget: (value, meta) {
                    if (value == 0.0)
                      return Text(
                        'Buruk',
                        style: kalmOfflineTheme.textTheme.overline!
                            .apply(color: secondaryText, fontSizeFactor: 1),
                      );
                    if (value == 1.0)
                      return Text(
                        'Biasa',
                        style: kalmOfflineTheme.textTheme.overline!
                            .apply(color: secondaryText, fontSizeFactor: 1),
                      );
                    if (value == 2.0)
                      return Text(
                        'Baik',
                        style: kalmOfflineTheme.textTheme.overline!
                            .apply(color: secondaryText, fontSizeFactor: 1),
                      );
                    else
                      return const Text('');
                  },
                  // margin: 20,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 15,
                  // getTextStyles: (_, value) {
                  //   return kalmOfflineTheme.textTheme.overline!
                  //       .apply(color: secondaryText, fontSizeFactor: 1.1);
                  // },
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return Text(
                          'Sen',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      case 1:
                        return Text(
                          'Sel',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      case 2:
                        return Text(
                          'Rab',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      case 3:
                        return Text(
                          'Kam',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      case 4:
                        return Text(
                          'Jum',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      case 5:
                        return Text(
                          'Sab',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      case 6:
                        return Text(
                          'Min',
                          style: kalmOfflineTheme.textTheme.overline!
                              .apply(color: secondaryText, fontSizeFactor: 1),
                        );
                      default:
                        return const Text('');
                    }
                  },
                  // margin: 10,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: secondaryText.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: secondaryText.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(
                  color: primaryColor,
                  width: 3,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: widget.graphData
                    .map(
                      (data) => FlSpot(
                        data.index.toDouble(),
                        data.mood.toDouble(),
                      ),
                    )
                    .toList(),
                isCurved: true,
                color: primaryColor,
                barWidth: 2,
                dotData: FlDotData(
                  show: false,
                  getDotPainter: (spot, value, chartData, int) {
                    return FlDotCirclePainter(
                      color: primaryColor,
                      strokeColor: primaryColor,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.5),
                      primaryColor.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              enabled: true,
              getTouchedSpotIndicator: (data, index) {
                return index
                    .map(
                      (e) => TouchedSpotIndicatorData(
                        FlLine(
                          color: primaryColor,
                          strokeWidth: 2,
                        ),
                        FlDotData(
                          show: true,
                          getDotPainter: (spot, value, chartData, int) {
                            return FlDotCirclePainter(
                              color: primaryColor,
                              strokeColor: primaryColor,
                            );
                          },
                        ),
                      ),
                    )
                    .toList();
              },
              touchTooltipData: LineTouchTooltipData(getTooltipItems: (value) {
                return value
                    .map((spot) => LineTooltipItem(
                        spot.y == 0
                            ? 'Buruk'
                            : spot.y == 1
                                ? 'Biasa'
                                : 'Baik',
                        kalmOfflineTheme.textTheme.overline!
                            .apply(color: tertiaryColor)))
                    .toList();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
