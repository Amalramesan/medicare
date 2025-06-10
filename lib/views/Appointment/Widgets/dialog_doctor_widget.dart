import 'package:flutter/material.dart';
import 'package:med_care/Models/doctor_model.dart';
import 'package:med_care/Services/api_services.dart';

class SelectDoctorStep extends StatefulWidget {
  final VoidCallback onContinue;
  final ValueChanged<DoctorModel> onDoctorSelected;
  final VoidCallback onBack;
  final DateTime selectedDate;

  const SelectDoctorStep({
    super.key,
    required this.onContinue,
    required this.onDoctorSelected,
    required this.onBack,
    required this.selectedDate,
  });

  @override
  State<SelectDoctorStep> createState() => _SelectDoctorStepState();
}

class _SelectDoctorStepState extends State<SelectDoctorStep> {
  DoctorModel? selectedDoctor;
  late Future<List<DoctorModel>> doctorFuture;

  @override
  void initState() {
    super.initState();
    doctorFuture = ApiServices().fetchDoctorBytime(
      widget.selectedDate.toIso8601String().split("T")[0],
    );
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.6;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: FutureBuilder<List<DoctorModel>>(
          future: doctorFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No doctors available."));
            } else {
              final doctors = snapshot.data!;

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
                          selectedDoctor = doc;
                        });
                        widget.onDoctorSelected(doc);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selectedDoctor?.id == doc.id
                              ? Colors.blue[50]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedDoctor?.id == doc.id
                                ? Colors.blue
                                : Colors.grey[300]!,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.network(doc.imageUrl, width: 48, height: 48),
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
                                    doc.specialization,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    doc.hospital,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: doc.availableToday
                                            ? Colors.green.withOpacity(0.1)
                                            : Colors.red.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: doc.availableToday
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            doc.availableToday
                                                ? Icons.check_circle
                                                : Icons.cancel,
                                            color: doc.availableToday
                                                ? Colors.green
                                                : Colors.red,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            doc.availableToday
                                                ? "Available"
                                                : "Not available",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: doc.availableToday
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                        onPressed: widget.onBack,
                        child: const Text("Back"),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: selectedDoctor != null
                            ? widget.onContinue
                            : null,
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
          },
        ),
      ),
    );
  }
}
