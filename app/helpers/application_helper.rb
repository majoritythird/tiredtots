module ApplicationHelper

  def data_url
    @data_url || ""
  end

  def cache_as(url, unique = false)
    suffix = unique ? "/#{Time.zone.now.to_f}/" : ""
    @data_url = url + suffix
  end

end
