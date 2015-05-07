module ApplicationHelper
	def fullTitle(pageTitle='')
		baseTitle="Moorgoo Tutor"
		if pageTitle.empty?
			baseTitle
		else
			"#{pageTitle} | " + baseTitle
		end
	end
end
