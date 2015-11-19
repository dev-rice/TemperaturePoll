require './ascii_charts_mine'
require 'cpu'

proc = CPU::Processor.new(0)

period = 0.5
num_points = 50
time = 0
data = []
while true do
    current_temperature = proc.temperature
    data << [time.to_i, current_temperature]

    trimmed_data = data.last(num_points)
    num_elements = trimmed_data.length
    if (num_elements < num_points) then
        last_time = trimmed_data[num_elements - 1][0]
        (num_points - num_elements).times { |i|
            trimmed_data << [last_time + (i + 1), 0]
        }
    end

    system "clear" or system "cls"

    min_y = 20
    max_y = 55
    step_size = 1
    puts AsciiCharts::ChrisChart.new(trimmed_data, 
                                    :min_y_vals => min_y,
                                    :max_y_vals => max_y,
                                    :hide_zero => true,
                                    :title => "CPU Temperature",
                                    :bar => true).draw

    sleep(period)
    time += 1
end
