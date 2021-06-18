abstract class Appointment {
  final int id;
  final DateTime start;
  final DateTime end;
  Appointment({
    required this.id,
    required this.start,
    required this.end,
  });
}

class PatientAppointment extends Appointment {
  final String doctorName;

  PatientAppointment({
    required int id,
    required DateTime start,
    required DateTime end,
    required this.doctorName,
  }) : super(
          id: id,
          start: start,
          end: end,
        );
}
