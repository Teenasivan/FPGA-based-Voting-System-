# FPGA-based-Voting-System-
This project presents the design and implementation of a Digital Voting Machine 
System using digital logic modules to record, process, and display vote counts. The 
system is composed of three main modules: the Voting Machine Module, the Digits 
Module, and the Seven-Segment Display Module. Together, these modules enable 
secure vote casting, real-time count tracking, and dynamic visual representation of 
results on a digital display. 
The Voting Machine Module forms the core of the system. It maintains separate 
registers to track vote counts for three voting options: BJP, CONG, and NOTA. Each 
option is associated with a push button; when pressed, the corresponding count is 
incremented, and a confirmation signal (e.g., BJP_CONF) is generated. This signal 
triggers an LED or similar indicator to provide instant visual feedback, confirming 
that the vote has been successfully registered. A system-wide reset function is 
available to clear all vote counts and restore the system to its initial state. 
Additionally, this module interacts with the Digits Module to determine which party’s 
vote count is currently selected for display, based on control signals such as BJP_FIG, 
CONG_FIG, and NOTA_FIG. 
The Digits Module is responsible for converting the total vote count of the selected 
party into a four-digit format. It takes the vote counts of BJP, CONG, and NOTA as 
input and, depending on which figure select signal is active, isolates the corresponding 
count. This count is then broken down into thousands, hundreds, tens, and ones using 
arithmetic division and modulo operations. These individual digit outputs are passed 
to the Seven-Segment Display Module for visualization. 
Finally, the Seven-Segment Display Module provides a visual representation of the 
vote count on a four-digit display. It uses a 2-bit counter (digit_select) to cycle rapidly 
through the thousands, hundreds, tens, and ones digits, enabling one digit at a time. 
This multiplexing creates the illusion of all digits being displayed simultaneously to 
the human eye. A timer (digit_timer) controls the refresh rate, ensuring that each digit 
is updated approximately every 1 ms. The digit values are decoded into corresponding 
seven-segment patterns using a case-based logic structure that maps binary numbers 
(0-9) to display configurations. 
