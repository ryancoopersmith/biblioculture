class Api::V1::SitesController < ApiController
  def index
    render json: Site.all
  end
end
