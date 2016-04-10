class SearchController < RestrictedAreaController

  def index

    #unfortunately simple_form requires a model nesting for parameters
    if params[:user] then
      @users = User.search(params[:user][:username]).page(params[:page])
      @last_query = params[:user][:username];
    end

  end
  
end
