# require './app/poro/holiday'

class HolidayService

	def self.holidays
		response = Faraday.get("https://date.nager.at/Api/v1/Get/US/2021")
		parsed = JSON.parse(response.body, symbolize_names:true)
		holidays = parsed.map do |data|
			Holiday.new(data)
		end
	end

  def self.future_holidays
    future_holidays = holidays.find_all do |holiday|
      Date.today < holiday.date
    end
  end

  def self.upcoming_holidays
    future_holidays[0..2]
  end

end
