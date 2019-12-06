require_relative '../models/webinar'

class WebinarsController < OverrideController
  def index
    @webinars = Webinar.all_webinars
    @page_title = 'Webinars for Educators'
  end

  def show
    @webinar = Webinar.find_by_path(params[:path])
    @page_title = @webinar.title
    params[:path] = nil
  end
end
