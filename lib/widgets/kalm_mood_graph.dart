import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kalm/utilities/kalm_theme.dart';

class KalmMoodGraph extends StatefulWidget {
  @override
  _KalmMoodGraphState createState() => _KalmMoodGraphState();
}

class _KalmMoodGraphState extends State<KalmMoodGraph> {
  final List<Map<String, double>> graphData = [
    {
      'index': 0,
      'value': 2,
    },
    {
      'index': 1,
      'value': 1,
    },
    {
      'index': 2,
      'value': 2,
    },
    {
      'index': 3,
      'value': 1,
    },
    {
      'index': 4,
      'value': 2,
    },
    {
      'index': 5,
      'value': 1,
    },
    {
      'index': 6,
      'value': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
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
              rightTitles: SideTitles(
                showTitles: true,
                reservedSize: 5,
                getTitles: (value) {
                  return '';
                },
              ),
              topTitles: SideTitles(
                showTitles: true,
                reservedSize: 5,
                getTitles: (value) {
                  return '';
                },
              ),
              leftTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTextStyles: (_, value) {
                  return kalmOfflineTheme.textTheme.overline!
                      .apply(color: secondaryText, fontSizeFactor: 1.1);
                },
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Buruk';
                    case 1:
                      return 'Biasa';
                    case 2:
                      return 'Baik';
                    default:
                      return '';
                  }
                },
                margin: 20,
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 15,
                getTextStyles: (_, value) {
                  return kalmOfflineTheme.textTheme.overline!
                      .apply(color: secondaryText, fontSizeFactor: 1.1);
                },
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Sen';
                    case 1:
                      return 'Sel';
                    case 2:
                      return 'Rab';
                    case 3:
                      return 'Kam';
                    case 4:
                      return 'Jum';
                    case 5:
                      return 'Sab';
                    case 6:
                      return 'Min';
                    default:
                      return '';
                  }
                },
                margin: 10,
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
                  width: 4,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: graphData
                    .map(
                      (data) => FlSpot(
                        data['index']!,
                        data['value']!,
                      ),
                    )
                    .toList(),
                isCurved: true,
                colors: [
                  primaryColor,
                ],
                barWidth: 3,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, value, chartData, int) {
                    return FlDotCirclePainter(
                      color: primaryColor,
                      strokeColor: primaryColor,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  colors: [
                    primaryColor.withOpacity(0.5),
                    primaryColor.withOpacity(0),
                  ],
                  gradientFrom: Offset(0, 0),
                  gradientTo: Offset(0, 1),
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
