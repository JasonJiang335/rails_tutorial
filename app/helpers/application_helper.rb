module ApplicationHelper
	def fullTitle(pageTitle='')
		baseTitle="Ruby on Rails Tutorial Sample App"
		if pageTitle.empty?
			baseTitle
		else
			"#{pageTitle} | " + baseTitle
		end
	end
end
