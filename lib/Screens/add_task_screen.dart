import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/Services/validator_service.dart';
import 'package:flutter_tasks_app/Widgets/task_color.dart';
import 'package:flutter_tasks_app/Widgets/task_lable.dart';
import 'package:flutter_tasks_app/Widgets/task_textfield.dart';
import 'package:flutter_tasks_app/models/task_model.dart';
import 'package:hive_flutter/adapters.dart';

class AddTaskScreen extends StatefulWidget {
 const  AddTaskScreen({super.key});
   
 

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final dateCtrl = TextEditingController(text: '2025-05-17');
  final startTimeCtrl = TextEditingController(text: '09:08 PM');
  final endTimeCtrl = TextEditingController(text: '09:08 PM');

   TimeOfDay stime=TimeOfDay.now(), etime=TimeOfDay.now();


 final colorsList = [
   Colors.blue,
   Colors.orange,
   Colors.pink,
    ];

  int selectedColor = 0;
 final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.blue),
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode:AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskLable(text: 'Title'),
                TaskTextfield(
                  hint: 'Enter title',
                  controller: titleCtrl,
                  validate:ValidatorService.validateTitle ,
                  
                ),
                
                const SizedBox(height: 16),
                TaskLable(text: 'Description'),
                TaskTextfield(
                  hint: 'Enter description',
                  controller: descCtrl,
                  maxLines: 4,
                   validate:ValidatorService.validateDes,
                ),
                
                const SizedBox(height: 16),
                TaskLable(text: 'Date'),
                TaskTextfield(
                  hint: '',
                  controller: dateCtrl,
                  readOnly: true,
                  suffixIcon: const Icon(Icons.calendar_today),
                  onTap: () {
                    showDatePicker(context: context, firstDate: DateTime.now(), 
                    lastDate: DateTime.now().add(Duration(days: 90))).then( (value) {
                      if (value != null) {
                        dateCtrl.text =
                            '${value.day.toString().padLeft(2, '0')}-${value.month.toString().padLeft(2, '0')}-${value.year}';
                      }
                    });
                  },
                ),
                
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TaskLable(text: 'Start Time'),
                          TaskTextfield(
                            hint: '',
                            controller: startTimeCtrl,
                            readOnly: true,
                            suffixIcon: const Icon(Icons.access_time),
                            onTap: () {
                              showTimePicker(context: context, initialTime:TimeOfDay.now()).then((value) {
                                if (value != null) {
                                  stime=value;
                                  final hour = value.hourOfPeriod.toString().padLeft(2, '0');
                                  final minute = value.minute.toString().padLeft(2, '0');
                                  final period = value.period == DayPeriod.am ? 'AM' : 'PM';
                                  startTimeCtrl.text = '$hour:$minute $period';
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TaskLable(text: 'End Time'),
                          TaskTextfield(
                            hint: '',
                            controller: endTimeCtrl,
                            readOnly: true,
                            suffixIcon: const Icon(Icons.access_time),
                            onTap: () {
                              showTimePicker(context: context, initialTime:TimeOfDay.now()).then((value) {
                                if (value != null) {
                                  etime=value;
                                  final hour = value.hourOfPeriod.toString().padLeft(2, '0');
                                  final minute = value.minute.toString().padLeft(2, '0');
                                  final period = value.period == DayPeriod.am ? 'AM' : 'PM';
                                  endTimeCtrl.text = '$hour:$minute $period';
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                TaskLable(text: 'Color'),
                Row(
                  children: List.generate(3, (index) {
                   
                
                  return  TaskColor(color: colorsList[index] ,
                    selectedColor: selectedColor == index,
                    onTap: () {
                      setState(() => selectedColor = index);
                    },);

                 
                  }),
                ),
                 const SizedBox(height: 60),
                //const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text(
                      'Create Task',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
 void _submitForm() {
    if (_formKey.currentState!.validate()) {
     
      if (stime.hour>etime.hour || (stime.hour==etime.hour && stime.minute>=etime.minute)) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("End time must be after start time"),
        ),);
        return; 
      }

       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form is valid'),
          duration: Duration(seconds: 3),
        ),

      );
 
      Hive.box<TaskModel>("task").add(
       TaskModel(
          taskTitle: titleCtrl.text,
          statusText: "Todo",
          description: descCtrl.text,
          date: dateCtrl.text,
          startTime: startTimeCtrl.text,
          endTime: endTimeCtrl.text,
          color: (colorsList[selectedColor].toARGB32()),
        )
        );

       /*tasks.add(TaskModel(
          taskTitle: titleCtrl.text,
          statusText: "Todo",
          description: descCtrl.text,
          date: dateCtrl.text,
          startTime: startTimeCtrl.text,
          endTime: endTimeCtrl.text,
          color: colorsList[selectedColor].hashCode,
        ));*/

      Navigator.of(context).pop();
    }
  }

}
    
  

