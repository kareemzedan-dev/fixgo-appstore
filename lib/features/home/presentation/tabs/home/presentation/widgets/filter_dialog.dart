
// import 'package:flutter/material.dart';


// class FilterDialog extends StatefulWidget {
//   final String? initialCity;
//   final String? initialNeighborhood;
//   final String? orderServicesBy;
//   final Function(String?, String?, String?) onApply;

//   const FilterDialog({
//     super.key,
//     this.initialCity,
//     this.initialNeighborhood,
//     this.orderServicesBy,
//     required this.onApply,
//   });

//   @override
//   _FilterDialogState createState() => _FilterDialogState();
// }

// class _FilterDialogState extends State<FilterDialog> {
//   String? selectedCity;
//   String? selectedNeighborhood;
//   String? selectedOrderServicesBy;

//   @override
//   void initState() {
//     super.initState();
//     selectedCity = widget.initialCity;
//     selectedNeighborhood = widget.initialNeighborhood;
//     selectedOrderServicesBy = widget.orderServicesBy;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       title: const Text(
//         "تصفية الخدمات",
//         style: TextStyle(fontFamily: 'NeoSansArabic'),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           DropdownButtonFormField<String>(
//             initialValue: selectedCity,
//             hint: const Text('اختر المدينة', style: TextStyle(fontFamily: 'NeoSansArabic')),
//             isExpanded: true,
//             items: cities.keys.map((city) {
//               return DropdownMenuItem<String>(
//                 value: city,
//                 child: Text(city, style: const TextStyle(fontFamily: 'NeoSansArabic')),
//               );
//             }).toList(),
//             onChanged: (newCity) {
//               setState(() {
//                 selectedCity = newCity;
//                 selectedNeighborhood = null;
//               });
//             },
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           DropdownButtonFormField<String>(
//             initialValue: selectedNeighborhood,
//             hint: const Text('اختر الحي', style: TextStyle(fontFamily: 'NeoSansArabic')),
//             isExpanded: true,
//             items: selectedCity != null
//                 ? cities[selectedCity]!.map((neighborhood) {
//               return DropdownMenuItem<String>(
//                 value: neighborhood,
//                 child: Text(neighborhood,
//                     style: const TextStyle(fontFamily: 'NeoSansArabic')),
//               );
//             }).toList()
//                 : [],
//             onChanged: (newNeighborhood) {
//               setState(() {
//                 selectedNeighborhood = newNeighborhood;
//               });
//             },
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 10),
//           DropdownButtonFormField<String>(
//             initialValue: selectedOrderServicesBy,
//             hint: const Text('ترتيب حسب', style: TextStyle(fontFamily: 'NeoSansArabic')),
//             isExpanded: true,
//             items: generateOrderServicesByItems(),
//             onChanged: (newOrderServicesBy) {
//               setState(() {
//                 selectedOrderServicesBy = newOrderServicesBy;
//               });
//             },
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: const BorderSide(color: Colors.grey),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           onPressed: ()
//           {
//           Navigator.of(context).pop(); // إلغاء العملية
//         },
//           child: const Text("إلغاء", style: TextStyle(color: Colors.red ,             fontFamily: 'NeoSansArabic',
//           )),
//         ),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           onPressed: ()
//           {
//             widget.onApply(selectedCity, selectedNeighborhood, selectedOrderServicesBy);
//           },
//           child: const Text("تأكيد", style: TextStyle(color: Color(0xFF3B82A0) ,             fontFamily: 'NeoSansArabic',
//           )),
//         ),
//       ],
//     );
//   }

//   List<DropdownMenuItem<String>> generateOrderServicesByItems()
//   {
//     List<DropdownMenuItem<String>> items = [];

//     for (var value in orderServicesBy)
//     {
//       items.add(
//           DropdownMenuItem<String>(
//             value: value,
//             child: Text(orderServicesByTitles[value.toString()]!,
//                 style: const TextStyle(fontFamily: 'NeoSansArabic')),
//           )
//       );
//     }

//     return items;
//   }
// }

