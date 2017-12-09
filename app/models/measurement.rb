class Measurement < ApplicationRecord

  # V A L I D A T I O N S
  validates :measured_at, presence: true

  # R E L A T I O N S
  belongs_to :user


  # This method counts and outputs average temperature and humidity of measurements made between
  # given time range - separately for each hour. Within each of these hours it also computes and
  # outputs average temperature and humidity values of measurements made each n minutes in this
  # hour - so that these averages can be compared.
  # Parameters:
  #   global_begin_time / global_end_time: DateTime values - the time range
  #   minutes_offset: how many minutes to offset when calculating average values within the hour 
  def self.compare_averages(global_begin_time, global_end_time, minutes_offset)
    t1 = global_begin_time
    t2 = t1 + 1.hour

    loop do
      end_time = t2 > global_end_time ? global_end_time : t2
      puts "\n\n\n#{t1.strftime('%H:%M:%S')} - #{end_time.strftime('%H:%M:%S')}"
      measurements = Measurement.where('measured_at >= ? and measured_at < ?', t1, end_time).order(:measured_at)
      m_count = measurements.count

      if m_count == 0
        puts "No measurements within range."
        return
      end

      # Count average values
      t_sum = measurements.sum(:temperature)
      h_sum = measurements.sum(:humidity)
      
      puts "Avg T = #{t_sum / m_count}"
      puts "Avg H = #{h_sum / m_count}"

      # Count average values from each n minutes measurements
      t_sum = 0
      h_sum = 0
      m_count = 0
      
      while measurement = measurements.first
        t_sum += measurement.temperature
        h_sum += measurement.humidity
        m_count += 1

        t1 += minutes_offset.minutes
        measurements = Measurement.where('measured_at >= ? and measured_at < ?', t1, end_time).order(:measured_at)
      end

      puts "Avg T (by #{minutes_offset} mins) = #{t_sum / m_count}"
      puts "Avg H (by #{minutes_offset} mins) = #{h_sum / m_count}"

      # Set next iteration data
      t1 = end_time
      t2 += 1.hour
      break if end_time == global_end_time
    end
  end
end
