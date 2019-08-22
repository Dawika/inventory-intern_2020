module CandidatesHelper
  def link_to_path(name, id)
		link_to name.to_s, "/somsri#/candidate/detail/#{id}"
	end
end
