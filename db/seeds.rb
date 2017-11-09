# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).


# raise "Environment does not support seeds!" if Rails.env.eql?('production')
User.destroy_all
user = User.new
user.email = 'bravcove@plece.com'
user.password = 'bravcoveplece'
user.password_confirmation = 'bravcoveplece'
user.save!


Product.destroy_all

10.times do
  phase_end_at = nil
  product = Product.new(
    user_id: user.id,
    name: Faker::Beer.name,
    label: Faker::Code.isbn
  )

  phases_count = rand(0..3)
  
  phases_count.times do |i|
    days_count = rand(2..5)

    if i == 0
      phase_begin_at = Faker::Time.between(20.days.ago, 15.days.ago)
    else
      phase_begin_at = phase_end_at
      phase_end_at = nil
    end

    

    if i < phases_count - 1
      phase_planned_end_at = phase_begin_at + days_count.days
      phase_end_at = phase_planned_end_at
    else
      phase_planned_end_at = Faker::Time.between(2.days.ago, 5.days.from_now)
      phase_end_at = phase_planned_end_at if phase_planned_end_at < Date.today
    end

    product.phases << product.phases.new(
      name: Faker::Book.title,
      begin_at: phase_begin_at,
      planned_end_at: phase_planned_end_at,
      end_at: phase_end_at
    )
  end

  product.save
end


Measurement.destroy_all

30.times do 
  measurement = Measurement.new(
    user_id: user.id,
    measured_at: Faker::Time.between(20.days.ago, Date.yesterday, :all),
    temperature: rand(3..9),
    humidity: rand(20..70)
  )

  measurement.save
end
