class Domain < ActiveRecord::Base

	def self.create_bunch(list, comment)
		next_check_date = Time.now

		list.each do |e|
			Domain.create(name: e, comment: comment, next_check_date: next_check_date)
		end
	rescue 
		nil	
	end

	def self.to_check_list
		Domain.where("next_check_date < ?", Time.now)
	end

	def generate_next_check_date
		time_now = Time.now

		diff_days = (self.expiration_date.to_date - time_now.to_date).to_i
		if diff_days < 30
			next_time = time_now + 1.day
		else
			next_time = time_now + 1.month	
		end	

		next_time
	rescue
		Time.now + 1.day	
	end

	def self.ordered_list
		with_exp_date = Domain.where.not(expiration_date: nil).order("expiration_date ASC")
		without_exp_date = Domain.where(expiration_date: nil)
		with_exp_date + without_exp_date
	end
end
