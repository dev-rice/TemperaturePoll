require './ascii_charts_mine'
require 'cpu'

proc = CPU::Processor.new(0)

period = 1
time = 0
data = []
while true do
    current_temperature = proc.temperature
    data << [time.to_i, current_temperature]
    
    trimmed_data = data.last(40)
    num_elements = trimmed_data.length
    if (num_elements < 40) then
        last_time = trimmed_data[num_elements - 1][0]
        (40 - num_elements).times { |i|
            trimmed_data << [last_time + period * (i + 1), 0]
        }
    end

    system "clear" or system "cls"

    min_y = 20
    max_y = 60
    step_size = 1
    puts AsciiCharts::Cartesian.new(trimmed_data, 
                                    :min_y_vals => min_y, 
                                    :max_y_vals => max_y, 
                                    :y_step_size => step_size,
                                    :hide_zero => true,
                                    :title => "CPU Temperature").draw    

    sleep(period)
    time += period
end
