class ErrorController < ApplicationController
  layout 'error'

  def show
    @exception = env['action_dispatch.exception']
    render action: request.path[1..-1]
  end
end
  