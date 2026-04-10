import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'data.dart';
import 'study.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> statusCounts = {
      'Not Started': 0,
      'Started': 0,
      'In Process': 0,
      'Done': 0,
    };
    for (var task in sharedTasks) {
      String status = task['status'] ?? 'Started';
      if (statusCounts.containsKey(status)) {
        statusCounts[status] = statusCounts[status]! + 1;
      }
    }
    int totalTasks = sharedTasks.length;
    int doneTasks = sharedTasks.where((task) => task['done'] == true).length;

    return Container(
      color: Colors.black, // background color for the page
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar replacement
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Analytics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 20),

              const Text(
                "Performance Stats",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnalyticsCard(
                    label: 'Tasks Completed',
                    value: '$doneTasks/$totalTasks',
                    color: Colors.blue,
                  ),
                  AnalyticsCard(
                    label: 'Total hours studied',
                    value: '${(totalStudySeconds / 3600).toStringAsFixed(1)}h',
                    color: Colors.green,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StudyPage())),
                  ),
                  AnalyticsCard(
                    label: 'Academic Progress',
                    value: 'Track',
                    color: Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Task Status Pie Chart
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: statusCounts['Not Started']!.toDouble(),
                          title: 'Not Started',
                          color: Colors.grey,
                          radius: 50,
                        ),
                        PieChartSectionData(
                          value: statusCounts['Started']!.toDouble(),
                          title: 'Started',
                          color: Colors.orange,
                          radius: 50,
                        ),
                        PieChartSectionData(
                          value: statusCounts['In Process']!.toDouble(),
                          title: 'In Process',
                          color: const Color(0xFF4A7BFF),
                          radius: 50,
                        ),
                        PieChartSectionData(
                          value: statusCounts['Done']!.toDouble(),
                          title: 'Done',
                          color: Colors.green,
                          radius: 50,
                        ),
                      ],
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tasks Completed Graph
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BarChart(
                    BarChartData(
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: doneTasks.toDouble(),
                              color: Colors.green,
                              width: 20,
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: (totalTasks - doneTasks).toDouble(),
                              color: Colors.red,
                              width: 20,
                            ),
                          ],
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text('Completed', style: TextStyle(color: Colors.white, fontSize: 12));
                                case 1:
                                  return const Text('Pending', style: TextStyle(color: Colors.white, fontSize: 12));
                                default:
                                  return const Text('');
                              }
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Recent Activity",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              const ActivityCard(
                title: 'Completed ICT306 Assignment',
                subtitle: '2 hours ago',
              ),
              const ActivityCard(
                title: 'Attended Group Study ICT305',
                subtitle: 'Yesterday',
              ),
              const ActivityCard(
                title: 'Submitted Project ICT309',
                subtitle: '3 days ago',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Single stat card
class AnalyticsCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final VoidCallback? onTap;

  const AnalyticsCard(
      {super.key, required this.label, required this.value, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}

// Recent activity card
class ActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const ActivityCard({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          )
        ],
      ),
    );
  }
}