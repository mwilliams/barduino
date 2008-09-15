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
    @amount = serial_read
    digital_write pump, ON
    delay 4
    digital_write pump, OFF
  end

end
 
