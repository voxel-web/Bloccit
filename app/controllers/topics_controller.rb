class TopicsController < ApplicationController

  def index
    @topics = Topic.all
  end

  def create

    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash[:alert] = "Error creating topic. Please try again."
      renders :new
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    # Update action is similar to create action, except an existing object is
    # found first.
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was saved successfully."
      redirect_to @topic
    else
      flash[:alert] = "There was an error saving Topic. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index #why this instead of topic_path?
    else
      flash[:alert] = "There was an error deleting the topic."
      render :show
    end
  end

  private

  def topic_params
    # Specify params to be whitelisted for setting via mass assignment
    params.require(:topic).permit(:name, :description, :public)
  end

end
