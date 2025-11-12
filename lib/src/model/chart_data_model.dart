// Updated Model - represents a single data point
class ChartDataPoint {
  final num timestamp;
  final num price;
  final num marketCap;
  final num totalVolume;

  ChartDataPoint({
    required this.timestamp,
    required this.price,
    required this.marketCap,
    required this.totalVolume,
  });
}

// Response Model - represents the full API response
class ChartDataModel {
  final List<List<num>> prices;
  final List<List<num>> marketCaps;
  final List<List<num>> totalVolumes;

  ChartDataModel({
    required this.prices,
    required this.marketCaps,
    required this.totalVolumes,
  });

  factory ChartDataModel.fromJson(Map<String, dynamic> json) => ChartDataModel(
    prices: List<List<num>>.from(
      json["prices"].map((x) => List<num>.from(x.map((x) => x))),
    ),
    marketCaps: List<List<num>>.from(
      json["market_caps"].map(
        (x) => List<num>.from(x.map((x) => x)),
      ),
    ),
    totalVolumes: List<List<num>>.from(
      json["total_volumes"].map(
        (x) => List<num>.from(x.map((x) => x)),
      ),
    ),
  );

  // Convert to list of chart points for easier charting
  List<ChartDataPoint> toChartPoints() {
    List<ChartDataPoint> points = [];
    for (int i = 0; i < prices.length; i++) {
      points.add(ChartDataPoint(
        timestamp: prices[i][0],
        price: prices[i][1],
        marketCap: marketCaps[i][1],
        totalVolume: totalVolumes[i][1],
      ));
    }
    return points;
  }

  Map<String, dynamic> toJson() => {
    "prices": List<dynamic>.from(
      prices.map((x) => List<dynamic>.from(x.map((x) => x))),
    ),
    "market_caps": List<dynamic>.from(
      marketCaps.map((x) => List<dynamic>.from(x.map((x) => x))),
    ),
    "total_volumes": List<dynamic>.from(
      totalVolumes.map((x) => List<dynamic>.from(x.map((x) => x))),
    ),
  };
}