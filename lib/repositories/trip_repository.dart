import '../models/models.dart';

abstract class TripRepository {
  Future<List<Trip>> getAllTrips();
  Future<Trip?> getTripById(String id);
  Future<void> addTrip(Trip trip);
  Future<void> updateTrip(Trip trip);
  Future<void> deleteTrip(String id);
  Future<List<Trip>> searchTrips(String query);
}
