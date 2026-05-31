import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/stats.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({
    super.key,
    required this.items,
    this.labelFormatter,
  });

  final List<StatsItem> items;
  final String Function(String label)? labelFormatter;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox(
        height: 280,
        child: Center(
          child: Text('Noch keine Statistikdaten vorhanden.'),
        ),
      );
    }

    final maxMinutes = items.fold<int>(
      0,
      (maxValue, item) =>
          item.focusMinutes > maxValue ? item.focusMinutes : maxValue,
    );

    final maxY = _niceMaxYHours(maxMinutes);
    final interval = _intervalForMaxHours(maxY);

    return SizedBox(
      height: 300,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final index = group.x.toInt();

                if (index < 0 || index >= items.length) {
                  return null;
                }

                final item = items[index];
                final label = labelFormatter?.call(item.label) ?? item.label;

                return BarTooltipItem(
                  '$label\n${_formatMinutes(item.focusMinutes)}\n${item.pomodoros} Pomodoros',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          barGroups: [
            for (var index = 0; index < items.length; index++)
              BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: math.max(0, items[index].focusMinutes / 60),
                    width: 16,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ],
              ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 52,
                interval: interval,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8,
                    child: Text(
                      _formatYAxisValue(value),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 44,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value.roundToDouble() != value) {
                    return const SizedBox.shrink();
                  }

                  final index = value.toInt();

                  if (index < 0 || index >= items.length) {
                    return const SizedBox.shrink();
                  }

                  final step = items.length > 14 ? 3 : 1;
                  final isLast = index == items.length - 1;

                  if (index % step != 0 && !isLast) {
                    return const SizedBox.shrink();
                  }

                  final rawLabel = items[index].label;
                  final label = labelFormatter?.call(rawLabel) ?? rawLabel;

                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 10,
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: interval,
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

double _niceMaxYHours(int maxMinutes) {
  final maxHours = maxMinutes / 60;

  if (maxHours <= 1) {
    return 1;
  }

  if (maxHours <= 2) {
    return 2;
  }

  if (maxHours <= 5) {
    return 5;
  }

  if (maxHours <= 10) {
    return 10;
  }

  if (maxHours <= 24) {
    return 24;
  }

  if (maxHours <= 50) {
    return 50;
  }

  if (maxHours <= 100) {
    return 100;
  }

  return (maxHours / 50).ceil() * 50;
}

double _intervalForMaxHours(double maxY) {
  if (maxY <= 1) {
    return 0.25;
  }

  if (maxY <= 2) {
    return 0.5;
  }

  if (maxY <= 5) {
    return 1;
  }

  if (maxY <= 10) {
    return 2;
  }

  if (maxY <= 24) {
    return 4;
  }

  if (maxY <= 50) {
    return 10;
  }

  return 20;
}

String _formatYAxisValue(double value) {
  if (value == 0) {
    return '0 h';
  }

  if (value % 1 == 0) {
    return '${value.toInt()} h';
  }

  return '${value.toStringAsFixed(1)} h';
}

String _formatMinutes(int minutes) {
  final hours = minutes ~/ 60;
  final rest = minutes % 60;

  if (hours == 0) {
    return '$rest min';
  }

  if (rest == 0) {
    return '$hours h';
  }

  return '$hours h $rest min';
}
