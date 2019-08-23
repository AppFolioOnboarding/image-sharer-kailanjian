class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(params.require(:image).permit(:link, :tag_list))

    if @image.save
      flash[:success] = 'Successfully saved image'
      redirect_to @image
    else
      render new_image_path, status: :unprocessable_entity
    end
  end

  def index
    @tag = params[:tag]

    @images = if @tag.nil?
                Image.order(created_at: :desc)
              else
                Image.tagged_with(@tag).order(created_at: :desc)
              end
  end
end
