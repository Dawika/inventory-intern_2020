class SiteConfigsController < ApplicationController
  load_and_authorize_resource
  def index
    result = {}
    if @school_config
      if params[:names] && params[:names].kind_of?(Array)
        params[:names].each do |name|
          result[name.to_sym] = @school_config[name.to_sym]
        end
      elsif params[:name] && params[:name].kind_of?(String)
        result = @school_config[params[:name].to_sym]
      else
        result = @school_config
      end
    end
    render json: result
  end
end
