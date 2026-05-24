import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/stats.dart';

class StatsChart extends StatelessWidget {
  const StatsChart({super.key, required this.items});
  final List<StatsItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Noch keine Statistikdaten vorhanden.'));
    }
    return SizedBox(
      height: 240,
      child: BarChart(
        BarChartData(
          barGroups: [
            for (var i = 0; i < items.length; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                      toY: items[i].focusMinutes.toDouble(), width: 14)
                ],
              ),
          ],
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 42)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= items.length || index % 2 != 0) {
                    return const SizedBox.shrink();
                  }

                  final label = items[index].label;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                        label.length > 5
                            ? label.substring(label.length - 5)
                            : label,
                        style: const TextStyle(fontSize: 10)),
                  );
                },
              ),
            ),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}
