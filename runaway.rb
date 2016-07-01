require_relative './common.rb'

while true  do
  queue.subscribe({:block => true}) do |di, mt, pl|
    puts "#{pl}"
    sleep 0.1
  end
end
