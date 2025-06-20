import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
        highlightColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  final List<Map<String, dynamic>> cardData = [
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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => isLoading = false);
    });
  }

  void _toggleLoading() => setState(() => isLoading = !isLoading);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Parking'),
        actions: [
          IconButton(
            icon: Icon(isLoading ? Icons.visibility_off : Icons.refresh),
            tooltip: 'Toggle Shimmer',
            onPressed: _toggleLoading,
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: isLoading ? 4 : cardData.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (ctx, i) {
          if (isLoading) return const ParkingCard.shimmer();
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
  final String? title;
  final String? subtitle;
  final int? freeSpaces;
  final double? distanceKm;
  final bool isShimmer;
  static const double _radius = 16;

  const ParkingCard({
    super.key,
    this.title,
    this.subtitle,
    this.freeSpaces,
    this.distanceKm,
    this.isShimmer = false,
  });

  const ParkingCard.shimmer({super.key})
      : title = null,
        subtitle = null,
        freeSpaces = null,
        distanceKm = null,
        isShimmer = true;

  @override
  Widget build(BuildContext context) {
    // 1) Outer container with shadow always
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      padding: const EdgeInsets.all(12),

      // 2) If shimmer, only the skeleton inside is clipped & shimmered
      child: isShimmer
          ? Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title skeleton
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 22,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(_radius / 2),
                    ),
                  ),
                   Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],

              ),
              const SizedBox(height: 6),
              // subtitle skeleton lines
              Container(
                height: 14,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(_radius / 2),
                ),
              ),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(_radius / 2),
                    ),
                  ),
                  Container(
                    height: 14,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(_radius / 2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // freeSpaces badge skeleton
              Align(
                alignment: Alignment.centerRight,

              ),
              const SizedBox(height: 12),
              // icon circles skeleton
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // first 3 circles
                  ...List.generate(3, (_) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                  // some extra gap between groups (optional)
                const Spacer(),
                  // next 2 circles
                  ...List.generate(2, (_) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ],
              ),

            ],
          ),
        ),
      )
      // 3) Otherwise, your full card content:
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final leftWidgets = <Widget>[
      Image.asset('assets/images/bus.png', width: 20, height: 20),
      Image.asset('assets/images/train.png', width: 20, height: 20),
      Image.asset('assets/images/auto.png', width: 20, height: 20),
    ];
    final rightWidgets = <Widget>[
      Image.asset('assets/images/car.png', width: 20, height: 20),
      Image.asset('assets/images/bike.png', width: 20, height: 20),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // title + freeSpaces
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title ?? '',
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF3B8B01),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$freeSpaces Free space',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // subtitle + distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                subtitle ?? '',
                maxLines: 3,
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                  fontFamily: 'Segoe_UI',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${distanceKm?.toStringAsFixed(2)} Km',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // value-added & parking-type rows...
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Value Added Services'),
            const Text('Available Parking type'),
          ],
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (ctx) => FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: _buildBottomSheetContent(ctx, leftWidgets, rightWidgets),
                ),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  OverlappingIconRow(circleDiameter: 30, overlapOffset: 15, children: leftWidgets),
                  const SizedBox(width: 4),
                  const Text('+3 more'),
                ],
              ),
              Row(
                children: [
                  OverlappingIconRow(circleDiameter: 30, overlapOffset: 15, children: rightWidgets),
                  const SizedBox(width: 4),
                  const Text('+3 more'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSheetContent(
      BuildContext ctx, List<Widget> leftWidgets, List<Widget> rightWidgets) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Value Added Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(ctx).pop()),
          ],
        ),
        const SizedBox(height: 8),
        Row(children: leftWidgets.map((w) => Container(
          margin: const EdgeInsets.only(right: 8),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(color: Color(0xFF9EEE10), shape: BoxShape.circle),
          child: Center(child: w),
        )).toList()),
        const SizedBox(height: 12),
        const Text('- may contain Metro Feeder Bus, Metro rail, Metro Feeder Auto.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        const Text('Available Parking type', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(children: rightWidgets.map((w) => Container(
          margin: const EdgeInsets.only(right: 8),
          width: 40,
          height: 40,
          decoration: const BoxDecoration(color: Color(0xFF9EEE10), shape: BoxShape.circle),
          child: Center(child: w),
        )).toList()),
        const SizedBox(height: 12),
        const Text('- may contain bike, car, van, bus, bicycle parking.', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        const Text('* services and vehicle types may vary depending upon the specific parking space.',
            style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
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
    final totalWidth = circleDiameter + (children.length - 1) * (circleDiameter - overlapOffset);
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
                decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
                child: Center(child: children[i]),
              ),
            ),
        ],
      ),
    );
  }
}
