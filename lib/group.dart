import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Groups", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Study Groups",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Create Group"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: const [
                    GroupCard(
                      title: "ICT306 Advance Cyber Security",
                      subtitle: "Demonstration",
                      members: 5,
                      activity: "Active 2 hours ago",
                    ),
                    GroupCard(
                      title: "ICT305 Topic in IT",
                      subtitle: "Research",
                      members: 3,
                      activity: "Active Yesterday",
                    ),
                    GroupCard(
                      title: "ICT309 GRC",
                      subtitle: "Report",
                      members: 4,
                      activity: "Active Just now",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int members;
  final String activity;

  const GroupCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.members,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Image placeholder
          Container(
            height: 140,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: const Center(child: Icon(Icons.image)),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + members
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people,
                            size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(
                          "$members",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 10),

                const Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, color: Colors.grey),
                    SizedBox(width: 16),
                    Icon(Icons.description_outlined, color: Colors.grey),
                    SizedBox(width: 16),
                    Icon(Icons.calendar_today, color: Colors.grey),
                    SizedBox(width: 16),
                    Icon(Icons.video_call_outlined, color: Colors.grey),
                  ],
                ),

                const SizedBox(height: 10),
                Text(
                  activity,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}