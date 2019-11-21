require_relative '../models/webinar'

class WebinarsController < OverrideController
  def index
    @webinars = Webinar.all_top_level
    @page_title = 'AAPB Webinars'
  end

  def show
    @webinar = Webinar.find_by_path(params[:path])
    @page_title = @webinar.title
    params[:path] = nil
  end
end
