import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardData = [
      {
        'title': 'Technopark',
        'subtitle': 'Kazhakoottam, Trivandrum',
        'freeSpaces': 35,
        'distanceKm': 5.32,
      },
      {
        'title': 'City Mall Parking',
        'subtitle': 'MG Road, Kochi',
        'freeSpaces': 12,
        'distanceKm': 2.14,
      },
      {
        'title': 'Airport Parking',
        'subtitle': 'Nedumbassery, Kochi',
        'freeSpaces': 48,
        'distanceKm': 10.5,
      },
      {
        'title': 'Beachfront Lot',
        'subtitle': 'Varkala Beach, Thiruvananthapuram overflow test',
        'freeSpaces': 5,
        'distanceKm': 62.3,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Available Parking')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: cardData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final d = cardData[i];
          return ParkingCard(
            title: d['title'] as String,
            subtitle: d['subtitle'] as String,
            freeSpaces: d['freeSpaces'] as int,
            distanceKm: d['distanceKm'] as double,
          );
        },
      ),
    );
  }
}

class ParkingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int freeSpaces;
  final double distanceKm;

  const ParkingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.freeSpaces,
    required this.distanceKm,
  });

  @override
  Widget build(BuildContext context) {
    // define two different icon/image sets
    final leftWidgets = <Widget>[
      Image.asset('assets/images/bus.png', width: 20, height: 20),
      Image.asset('assets/images/train.png', width: 20, height: 20),
      Image.asset('assets/images/auto.png', width: 20, height: 20),
    ];
    final rightWidgets = <Widget>[
      Image.asset('assets/images/car.png', width: 20, height: 20),
      Image.asset('assets/images/bike.png', width: 20, height: 20),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B8B01),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$freeSpaces Free space',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  subtitle,
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ),

              Text(
                '${distanceKm.toStringAsFixed(2)} Km',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Value Added Services",
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ),
              // const SizedBox(height: 12),
              Flexible(
                child: Text(
                  "Available Parking type",
                  maxLines: 2,
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left set
                Row(
                  children: [
                    OverlappingIconRow(
                      children: leftWidgets,
                      circleDiameter: 30,
                      overlapOffset: 15,
                      circleColor: const Color(0xFF9EEE10),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+3 more',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),

                // Right set
                Row(
                  children: [
                    OverlappingIconRow(
                      children: rightWidgets,
                      circleDiameter: 30,
                      overlapOffset: 15,
                      circleColor: const Color(0xFF9EEE10),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+3 more',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) {
                  return FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Value Added Service',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9EEE10),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/bus.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9EEE10),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/train.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9EEE10),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/auto.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '- may contain Metro Feeder Bus,Metro rail,Metro Feeder Auto.',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Available Parking type',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // example second row
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9EEE10),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/car.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFF9EEE10),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/bike.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '- may contain bike,car,van,bus,bicycle parking.',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '* services and vehicle types may vary depending upon the specific parking space.',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class OverlappingIconRow extends StatelessWidget {
  final List<Widget> children;
  final double circleDiameter;
  final double overlapOffset;
  final Color circleColor;

  const OverlappingIconRow({
    super.key,
    required this.children,
    this.circleDiameter = 60,
    this.overlapOffset = 20,
    this.circleColor = const Color(0xFF9EEE10),
  }) : assert(children.length >= 1);

  @override
  Widget build(BuildContext context) {
    final totalWidth =
        circleDiameter +
        (children.length - 1) * (circleDiameter - overlapOffset);

    return SizedBox(
      width: totalWidth,
      height: circleDiameter,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < children.length; i++)
            Positioned(
              left: i * (circleDiameter - overlapOffset),
              child: Container(
                width: circleDiameter,
                height: circleDiameter,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(child: children[i]),
              ),
            ),
        ],
      ),
    );
  }
}
