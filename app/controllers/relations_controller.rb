class RelationsController < RestrictedAreaController

  def create

    # add a relation through the relations table
    @relation = current_user.relations.build(followed_id: params[:followed_id])

    if @relation.save then

      flash[:notice] = "#{t :following}#{@relation.following.username}"
      redirect_to user_timeline_path(@relation.following.username)

    else

      flash[:error] = t(:unable_to_follow)

    end

  end

  def destroy

    # destroy relation through the relations table
    @relation = current_user.relations.find_by_followed_id(params[:id])

    if @relation then

      @relation.destroy
      flash[:notice] = "#{t :unfollowing}#{@relation.following.username}"

    end

    redirect_to user_timeline_path(@relation.following.username)

  end

  # called by ajax, without id, just to update the seen timestamp
  def update
    current_user.followers_check_timestamp = Time.now
    current_user.save
    render nothing: true, status: 200, content_type: 'text/html'
  end

end
