# From https://itshouldbeuseful.wordpress.com/2010/11/10/find-your-slowest-running-cucumber-features/

scenario_times = {}

Around do |scenario, block|
  name = "#{scenario.feature.file}::#{scenario.name}"
  start = Time.now
  block.call
  end_time = Time.now
  scenario_times[name] = end_time - start
end

at_exit do
  max_scenarios = scenario_times.size > 20 ? 20 : scenario_times.size
  puts "------------- Top #{max_scenarios} slowest scenarios -------------"
  sorted_times = scenario_times.sort { |a, b| b[1] <=> a[1] }
  sorted_times[0..max_scenarios - 1].each do |key, value|
    puts format("%.2f  %s", value, key)
  end
end
