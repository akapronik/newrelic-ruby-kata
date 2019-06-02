class ErrorsController < ApplicationController
  def index; end

  def ajax
    render :text => params['p'].to_i
  end
end
