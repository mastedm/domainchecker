class Domain < ActiveRecord::Base

	validates :status, inclusion: %w(pending checked unregistered)

	def self.create_bunch(list, comment)
		next_check_date = Time.now

		list.each do |e|
			e.downcase!
			next if Domain.where(name: e).any?
			Domain.create(name: e, comment: comment, next_check_date: next_check_date, status: "pending")
		end
	rescue 
		nil	
	end

	def self.to_check_list
		Domain.where("next_check_date < ?", Time.now)
	end

	def generate_next_check_date
		time_now = Time.now

		if self.expiration_date
			diff_days = (self.expiration_date.to_date - time_now.to_date).to_i

			if diff_days < 30
				next_time = time_now + 1.day
			else
				next_time = time_now + 1.month	
			end	
		else
			next_time = time_now + 1.day
		end	

		next_time
	rescue
		Time.now + 1.day	
	end

	def self.ordered_list
		with_exp_date = Domain.order("expiration_date is null, expiration_date ASC")
	end

	def to_unregistered
		self.status = "unregistered"
		self.next_check_date = self.generate_next_check_date
		self.save
	end
end
