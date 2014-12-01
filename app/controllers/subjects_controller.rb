class SubjectsController < ApplicationController

  layout false

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"})
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the obejct
    if @subject.save
      # If save succeds, redirect to the index action
      redirect_to(:action => 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # FInd an existing object using form parameters
    @subject = Subject.find(params[:id])
    # Update the obejct
    if @subject.update_attributes(subject_params)
      # If update succeds, redirect to the index action
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    redirect_to(:action => 'index')
  end

  private

    def subject_params
      # same as using "params[:subject]", except that it:
      # - raises an error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:subject).permit(:name, :position, :visible)
    end

end
