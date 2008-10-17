class Barduino < ArduinoSketch
 
  output_pin 5, :as => :pump_one
  output_pin 6, :as => :pump_two
  output_pin 13, :as => :led
  input_pin 0, :as => :photo_resistor
 
  serial_begin

  @serial_value = int
  @sensor = int
 
  def loop
    @sensor = analogRead(photo_resistor)
    if @sensor < 100
      digitalWrite led, ON
      if serial_available
        @serial_value = serial_read
        if @serial_value == '1'
          dispense pump_one
        end
        if @serial_value == '2'
          dispense pump_two
        end
      end
    else
      digitalWrite led, OFF
    end
  end

  def dispense(pump)
    # Hack for RubyToC to make it realize this dispense method
    # has a parameter to it (something along those lines).
    foo = pump + 0
    digitalWrite pump, ON
    delay 2000
    digitalWrite pump, OFF
  end

end
 
