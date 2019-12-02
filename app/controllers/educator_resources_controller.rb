class EducatorResourcesController < ApplicationController
  include EducatorResourcesHelper

  def index
    @educator_resources = EducatorResourcesHelper.all_educator_resources
  end

end
