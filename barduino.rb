class Barduino < ArduinoSketch
 
  output_pin 5, :as => :pump_one
  output_pin 6, :as => :pump_two

  serial_begin

  @serial_value = int
  @amount = int
 
  def loop
    if serial_available
      @serial_value = serial_read
      if @serial_value == '1'
        serial_println "Pump one ready..." 
        dispense pump_one
      end
      if @serial_value == '2'
        serial_println "Pump two ready..." 
        dispense pump_two
      end
    end
  end

  def dispense(pump)
    # Hack for RubyToC to make it realize this dispense method
    # has a parameter to it (something along those lines).
    pump = 0 + pump
    @amount = serial_read
    digitalWrite pump, ON
    delay 5000
    digitalWrite pump, OFF
    # Add a delay to prevent whatever is driving this from getting
    # ahead of the serial port.
    delay 2000
  end

end
 
