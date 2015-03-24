class DomainsController < ApplicationController
	def index
		@count = Domain.count
		@domains = Domain.ordered_list.paginate(:page => params[:page], :per_page => 30)
	end

	def new 
	end

	def create_bunch
		list = params[:list].split(/[\r\n]+/)
		comment = params[:comment]
		
		Rails.logger.debug list
		Rails.logger.debug comment
		
		if Domain.create_bunch(list, comment)
			redirect_to domains_path
		else 
			render "new"
		end

	end

	def destroy
		domain = Domain.find(params[:id])
		domain.destroy
    redirect_to domains_path
	end
end
