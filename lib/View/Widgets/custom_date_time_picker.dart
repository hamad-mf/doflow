import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker {
  static Future<DateTime?> showDateTimePicker(BuildContext context) async {
    DateTime? selectedDate = await _showDatePickerDialog(context);
    if (selectedDate == null) return null;
    
    TimeOfDay? selectedTime = await _showTimePickerDialog(context);
    if (selectedTime == null) return null;
    
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }
  
  static Future<DateTime?> _showDatePickerDialog(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime? selectedDate;
    
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.chevron_left, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                initialDate = DateTime(
                                  initialDate.year,
                                  initialDate.month - 1,
                                  initialDate.day,
                                );
                              });
                            },
                          ),
                          Text(
                            DateFormat('MMMM').format(initialDate).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_right, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                initialDate = DateTime(
                                  initialDate.year,
                                  initialDate.month + 1,
                                  initialDate.day,
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Year
                    Text(
                      initialDate.year.toString(),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    
                    SizedBox(height: 8),
                    
                    // Days of week header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _weekdayLabel('SUN', color: Colors.red[300]!),
                          _weekdayLabel('MON'),
                          _weekdayLabel('TUE'),
                          _weekdayLabel('WED'),
                          _weekdayLabel('THU'),
                          _weekdayLabel('FRI'),
                          _weekdayLabel('SAT', color: Colors.red[300]!),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 8),
                    
                    // Calendar grid
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: _buildCalendarGrid(initialDate, (date) {
                        selectedDate = date;
                        Navigator.of(context).pop();
                      }),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Actions
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.blue[300],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(initialDate);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(120, 40),
                            ),
                            child: Text('Choose Time'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );
      },
    );
    
    return selectedDate;
  }
  
  static Widget _weekdayLabel(String text, {Color color = Colors.white}) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  static Widget _buildCalendarGrid(DateTime currentMonth, Function(DateTime) onDateSelected) {
    // Calculate first day of the month
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    // Calculate the weekday (0 = Sunday, 1 = Monday, etc.)
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;
    // Calculate days in month
    final daysInMonth = DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    
    final today = DateTime.now();
    final isCurrentMonth = today.year == currentMonth.year && today.month == currentMonth.month;
    
    List<Widget> dayWidgets = [];
    
    // Add empty cells for days before the first day of month
    for (int i = 0; i < firstWeekdayOfMonth; i++) {
      dayWidgets.add(_buildDayCell(null));
    }
    
    // Add cells for each day of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      final isToday = isCurrentMonth && day == today.day;
      
      dayWidgets.add(_buildDayCell(
        day,
        isToday: isToday,
        onTap: () => onDateSelected(date),
      ));
    }
    
    // Calculate rows needed (ceiling of total cells / 7)
    final numRows = ((firstWeekdayOfMonth + daysInMonth) / 7).ceil();
    
    // Fill in remaining cells if needed
    while (dayWidgets.length < numRows * 7) {
      dayWidgets.add(_buildDayCell(null));
    }
    
    // Create rows of 7 cells each
    List<Widget> rows = [];
    for (int i = 0; i < numRows; i++) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayWidgets.sublist(i * 7, (i + 1) * 7),
        ),
      );
      if (i < numRows - 1) {
        rows.add(SizedBox(height: 4));
      }
    }
    
    return Column(children: rows);
  }
  
  static Widget _buildDayCell(int? day, {bool isToday = false, VoidCallback? onTap}) {
    final hasDay = day != null;
    
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: InkWell(
          onTap: hasDay ? onTap : null,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            decoration: BoxDecoration(
              color: isToday ? Colors.blue[400] : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: hasDay
                  ? Text(
                      day.toString(),
                      style: TextStyle(
                        color: isToday ? Colors.white : Colors.white,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
  
  static Future<TimeOfDay?> _showTimePickerDialog(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    int selectedHour = initialTime.hour;
    int selectedMinute = initialTime.minute;
    String period = selectedHour >= 12 ? 'PM' : 'AM';
    int hour12 = selectedHour > 12 ? selectedHour - 12 : (selectedHour == 0 ? 12 : selectedHour);
    String displayHour = hour12.toString().padLeft(2, '0');
    String displayMinute = selectedMinute.toString().padLeft(2, '0');
    
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void updateDisplayTime() {
              hour12 = selectedHour > 12 ? selectedHour - 12 : (selectedHour == 0 ? 12 : selectedHour);
              displayHour = hour12.toString().padLeft(2, '0');
              displayMinute = selectedMinute.toString().padLeft(2, '0');
            }
            
            void handleHourChange(int newHour) {
              setState(() {
                if (period == 'PM' && newHour != 12) {
                  selectedHour = newHour + 12;
                } else if (period == 'AM' && newHour == 12) {
                  selectedHour = 0;
                } else {
                  selectedHour = newHour;
                }
                updateDisplayTime();
              });
            }
            
            void handleMinuteChange(int newMinute) {
              setState(() {
                selectedMinute = newMinute;
                updateDisplayTime();
              });
            }
            
            void handlePeriodChange(String newPeriod) {
              setState(() {
                if (newPeriod != period) {
                  period = newPeriod;
                  if (period == 'PM' && selectedHour < 12) {
                    selectedHour += 12;
                  } else if (period == 'AM' && selectedHour >= 12) {
                    selectedHour -= 12;
                  }
                  updateDisplayTime();
                }
              });
            }
            
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Choose Time',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    Divider(color: Colors.grey[700], height: 1),
                    
                    // Time picker
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Hour picker
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF222222),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                displayHour,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          // Separator
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ':',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          // Minute picker
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF222222),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                displayMinute,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          
                          // AM/PM picker
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF222222),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                period,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Time selection controls
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Hour controls
                          _buildTimeControls(
                            onIncrement: () => handleHourChange((hour12 % 12) + 1),
                            onDecrement: () => handleHourChange(((hour12 - 2) % 12) + 1),
                          ),
                          
                          SizedBox(width: 24),
                          
                          // Minute controls
                          _buildTimeControls(
                            onIncrement: () => handleMinuteChange((selectedMinute + 1) % 60),
                            onDecrement: () => handleMinuteChange((selectedMinute - 1 + 60) % 60),
                          ),
                          
                          SizedBox(width: 24),
                          
                          // AM/PM controls
                          _buildTimeControls(
                            onIncrement: () => handlePeriodChange(period == 'AM' ? 'PM' : 'AM'),
                            onDecrement: () => handlePeriodChange(period == 'AM' ? 'PM' : 'AM'),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Actions
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.blue[300],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(
                                TimeOfDay(hour: selectedHour, minute: selectedMinute),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(120, 40),
                            ),
                            child: Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
    
    return TimeOfDay(hour: selectedHour, minute: selectedMinute);
  }
  
  static Widget _buildTimeControls({
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Column(
      children: [
        IconButton(
          onPressed: onIncrement,
          icon: Icon(Icons.keyboard_arrow_up, color: Colors.white),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          iconSize: 24,
        ),
        SizedBox(height: 16),
        IconButton(
          onPressed: onDecrement,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          iconSize: 24,
        ),
      ],
    );
  }
}