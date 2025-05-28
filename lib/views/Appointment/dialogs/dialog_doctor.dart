import 'package:flutter/material.dart';

class Doctor {
  final String name;
  final String specialty;
  final double rating;
  final String location;
  final String availability;
  final String imagepath;

  Doctor({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.location,
    required this.availability,
    required this.imagepath,
  });
}

class SelectDoctorStep extends StatefulWidget {
  final VoidCallback onContinue;
  final ValueChanged<String> onDoctorSelected;
  final VoidCallback onBack;

  const SelectDoctorStep({
    super.key,
    required this.onContinue,
    required this.onDoctorSelected,
    required this.onBack,
  });

  @override
  State<SelectDoctorStep> createState() => _SelectDoctorStepState();
}

class _SelectDoctorStepState extends State<SelectDoctorStep> {
  String? selectedDoctor;

  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr.Hemanth',
      specialty: 'Cardiologist',
      rating: 4.8,
      location: 'Main Hospital, Floor 3',
      availability: 'Available today',
      imagepath: 'assets/icons/doctor1.png',
    ),
    Doctor(
      name: 'Dr.joji',
      specialty: 'Dermatologist',
      rating: 4.7,
      location: 'West Wing Clinic',
      availability: 'Available tomorrow',
      imagepath: 'assets/icons/doctor2.png',
    ),
    Doctor(
      name: 'Dr. Anto',
      specialty: 'Pediatrician',
      rating: 4.9,
      location: 'Children\'s Center',
      availability: 'Available today',
      imagepath: 'assets/icons/doctor3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose a Doctor",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          "Select a doctor for your appointment",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ...doctors.map(
          (doc) => GestureDetector(
            onTap: () {
              setState(() {
                selectedDoctor = doc.name;
              });
              widget.onDoctorSelected(doc.name);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: selectedDoctor == doc.name
                    ? Colors.blue[50]
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedDoctor == doc.name
                      ? Colors.blue
                      : Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      doc.imagepath,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          doc.specialty,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          doc.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              final isFilled = index < doc.rating.floor();
                              return Icon(
                                isFilled ? Icons.star : Icons.star_border,
                                size: 16,
                                color: Colors.amber,
                              );
                            }),
                            const SizedBox(width: 4),
                            Text(
                              doc.rating.toString(),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      doc.availability,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            OutlinedButton(
              onPressed: widget.onBack, // Use onBack callback here
              child: const Text("Back"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedDoctor != null ? widget.onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedDoctor != null
                    ? Colors.blue
                    : Colors.grey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text("Continue"),
            ),
          ],
        ),
      ],
    );
  }
}
