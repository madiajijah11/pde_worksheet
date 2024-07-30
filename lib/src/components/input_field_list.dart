import 'package:flutter/material.dart';

class InputFieldList extends StatefulWidget {
  final String label;
  final List<Map<String, TextEditingController>> controllers;

  InputFieldList({required this.label, required this.controllers});

  @override
  _InputFieldListState createState() => _InputFieldListState();
}

class _InputFieldListState extends State<InputFieldList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.controllers.add({
                      'name': TextEditingController(),
                      'description': TextEditingController(),
                      'result': TextEditingController(),
                    });
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  textStyle: TextStyle(fontSize: 16.0),
                ),
                child: Text('Add ${widget.label}'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.controllers.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: widget.controllers[index]['name'],
                              decoration: InputDecoration(
                                  labelText:
                                      '${widget.label} Name ${index + 1}',
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                widget.controllers.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: widget.controllers[index]['description'],
                        decoration: InputDecoration(
                            labelText:
                                '${widget.label} Description ${index + 1}',
                            border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: widget.controllers[index]['result'],
                        decoration: InputDecoration(
                            labelText: '${widget.label} Result ${index + 1}',
                            border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
