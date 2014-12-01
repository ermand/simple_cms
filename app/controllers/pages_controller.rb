class PagesController < ApplicationController

  layout false

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @subjects = Subject.visible.sorted
    @page = Page.new({:name => "Default Page"})
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @subjects = Subject.visible.sorted
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    # Update existing page using form parameters
    if @page.update_attributes(page_params)
      # If save succeds, redirect to the index action
      flash[:notice] = "Page updated successfully."
      redirect_to(:action => 'show', :id => @page.id)
    else
      # If save fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name} deleted successfully."
    redirect_to(:action => 'index')
  end

  private

    def page_params
      # same as using "params[:page]", except that it:
      # - raises an error if :page is not present
      # - allows listed attributes to be mass-assigned
      params.require(:page).permit(:subject_id, :name, :position, :permalink, :visible)
    end
end
