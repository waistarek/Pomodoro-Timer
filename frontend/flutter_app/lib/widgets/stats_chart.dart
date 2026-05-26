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
        height: 240,
        child: Center(
          child: Text('Noch keine Statistikdaten vorhanden.'),
        ),
      );
    }

    final maxValue = items
        .map((item) => item.focusMinutes)
        .fold<int>(0, (max, value) => value > max ? value : max);

    final maxY = _niceMaxY(maxValue);
    final interval = _intervalForMax(maxY);

    return SizedBox(
      height: 280,
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
                  '$label\n${item.focusMinutes} min\n${item.pomodoros} Pomodoros',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          barGroups: [
            for (var i = 0; i < items.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: math.max(0, items[i].focusMinutes).toDouble(),
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

                  final step = items.length > 10 ? 2 : 1;
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

double _niceMaxY(int maxValue) {
  if (maxValue <= 0) {
    return 10;
  }

  if (maxValue <= 10) {
    return 10;
  }

  if (maxValue <= 30) {
    return 30;
  }

  if (maxValue <= 60) {
    return 60;
  }

  if (maxValue <= 120) {
    return 120;
  }

  if (maxValue <= 300) {
    return 300;
  }

  if (maxValue <= 600) {
    return 600;
  }

  if (maxValue <= 1200) {
    return 1200;
  }

  if (maxValue <= 1800) {
    return 1800;
  }

  return (maxValue / 500).ceil() * 500;
}

double _intervalForMax(double maxY) {
  if (maxY <= 10) {
    return 2;
  }

  if (maxY <= 30) {
    return 5;
  }

  if (maxY <= 60) {
    return 10;
  }

  if (maxY <= 120) {
    return 20;
  }

  if (maxY <= 300) {
    return 50;
  }

  if (maxY <= 600) {
    return 100;
  }

  if (maxY <= 1200) {
    return 200;
  }

  return 500;
}

String _formatYAxisValue(double value) {
  final rounded = value.round();

  if (rounded >= 1000) {
    final thousands = rounded / 1000;

    if (rounded % 1000 == 0) {
      return '${thousands.toStringAsFixed(0)}k';
    }

    return '${thousands.toStringAsFixed(1)}k';
  }

  return rounded.toString();
}