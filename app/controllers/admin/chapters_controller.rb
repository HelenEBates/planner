class Admin::ChaptersController < Admin::ApplicationController
  after_action :verify_authorized

  def new
    @chapter = Chapter.new
    authorize @chapter
  end

  def create
    @chapter = Chapter.new(chapter_params)
    authorize(@chapter)

    if @chapter.save
      flash[:notice] = "Chapter #{@chapter.name} has been succesfuly created"
      redirect_to [:admin, @chapter ]
    else
      flash[:notice] = @chapter.errors.full_messages
      render 'new'
    end
  end

  def show
    @chapter = Chapter.find(params[:id])
    authorize(@chapter)

    @workshops = @chapter.workshops
    @sponsors = @chapter.sponsors
    @groups = @chapter.groups
  end

  private

  def chapter_params
    params.require(:chapter).permit(:name, :email, :city)
  end
end