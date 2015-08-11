class EhlakOsoolController < ApplicationController

	def index
		if params['_year'].present?
			@_year = 	params['_year']
		else
			@_year = Time.now.year
		end

		@ehlak = EhlakOsool.where(year: @_year)
		if (!@ehlak || @ehlak.empty?)
			@ehlak = create_new @_year 
		end
		super
	end

	def update
		@ehlak = EhlakOsool.find(ehlak_osool_params[:id])
		@ehlak.update(ehlak_osool_params)
		render nothing: true
	end

	private

		def ehlak_osool_params
			params.require(:ehlak_osool).permit!
		end

		def create_new(year)
			EhlakOsool.create(name: "أجهزة كهربائية", rate: 12.5, value: 8368.54, year: year)
			EhlakOsool.create(name: "تكييفات", rate: 25, value: 12207, year: year)
			EhlakOsool.create(name: "أثاث", rate: 6, value: 26815, year: year)
			EhlakOsool.create(name: "أجهزة كمبيوتر وماكينة تصوير", rate: 25, value: 12006, year: year)
			EhlakOsool.create(name: "آلات", rate: 12.5, value: 239631, year: year)
			EhlakOsool.create(name: "عدد وأدوات", rate: 12.5, value: 8026.5, year: year)
			EhlakOsool.create(name: "موازين", rate: 12.5, value: 5525, year: year)
			EhlakOsool.create(name: "كلاركات", rate: 12.5, value: 25300, year: year)
			EhlakOsool.create(name: "انشاءات", rate: 5, value: 43806, year: year)
			EhlakOsool.create(name: "أخرى", rate: 0, value: 0, year: year)
			EhlakOsool.create(name: "أخرى", rate: 0, value: 0, year: year)
			EhlakOsool.create(name: "أخرى", rate: 0, value: 0, year: year)
			EhlakOsool.create(name: "أخرى", rate: 0, value: 0, year: year)
			EhlakOsool.create(name: "أخرى", rate: 0, value: 0, year: year)

			EhlakOsool.where(year: year)
		end
end
