require "serialport.so"

port_str = "/dev/tty.usbserial-A3000WS0"  #may be different for you
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
sp = SerialPort.new(port_str, baud_rate, 1000, data_bits, stop_bits, parity)
input = ""
while input != "q"
  puts "Light a light:"
  input = gets.chomp
  sp.putc input.to_s
end

sp.close                  
