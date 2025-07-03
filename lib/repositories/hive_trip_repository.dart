import 'package:hive/hive.dart';
import '../models/models.dart';
import 'trip_repository.dart';

class HiveTripRepository implements TripRepository {
  static const String _boxName = 'trips';
  late final Box<Trip> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Trip>(_boxName);
  }

  @override
  Future<List<Trip>> getAllTrips() async {
    return _box.values.toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  @override
  Future<Trip?> getTripById(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> addTrip(Trip trip) async {
    await _box.put(trip.id, trip);
  }

  @override
  Future<void> updateTrip(Trip trip) async {
    await _box.put(trip.id, trip);
  }

  @override
  Future<void> deleteTrip(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<Trip>> searchTrips(String query) async {
    final lowercaseQuery = query.toLowerCase();
    return _box.values
        .where((trip) =>
            trip.name.toLowerCase().contains(lowercaseQuery) ||
            trip.destination?.toLowerCase().contains(lowercaseQuery) == true ||
            trip.notes?.toLowerCase().contains(lowercaseQuery) == true)
        .toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }
}
