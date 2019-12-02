class ResourceSetsController < ApplicationController
  include ResourceSetsHelper

  def index
    @resource_sets = ResourceSetsHelper.all_resource_sets
  end

end
