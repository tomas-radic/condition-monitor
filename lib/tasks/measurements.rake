namespace :measurements do
  
  desc 'Calculates one daily average measurements of given day (and all previous), replaces measurements by one average measurement.'
  task(:change_for_daily_averages, [:date] => :environment) do |t, args|
    args.with_defaults(:date => (Date.today - 30.days))
    user = User.first
    date = Date.parse(args.date)
    now = Time.now

    loop do
      puts "\nDate #{date.to_s}"
      measurements_to_destroy = Measurement.where(
        'measured_at <= ?', date.end_of_day
      ).order(:measured_at)

      break if measurements_to_destroy.blank?

      measurements_to_destroy = measurements_to_destroy.where('measured_at >= ?', date.beginning_of_day)
      puts "Loaded measurements: #{measurements_to_destroy.pluck(:measured_at).map { |e| e.to_s }}"
    
      unless measurements_to_destroy.blank?
        temperatures = measurements_to_destroy.pluck(:temperature).compact
        humidities = measurements_to_destroy.pluck(:humidity).compact
        avg_temperature = temperatures.inject(0) { |memo, e| memo += e } / temperatures.length
        avg_humidity = humidities.inject(0) { |memo, e| memo += e } / humidities.length
        puts "Writing average: temperature #{avg_temperature}, humidity #{avg_humidity}"

        measurements_to_destroy.destroy_all
        Measurement.create(
          user: user,
          measured_at: DateTime.parse("#{date.to_s} 13:00 UTC"),
          temperature: avg_temperature,
          humidity: avg_humidity,
          averaged_at: now
        )
      end

      date -= 1.day
    end
  end
end
