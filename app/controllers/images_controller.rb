class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def show
    @image = Image.find(params[:id])
  end

  def create
    image_link = params[:image][:link]

    @image = Image.new(link: image_link)

    if @image.save
      flash[:success] = 'Successfully saved image'
      redirect_to @image
    else
      render new_image_path, status: :unprocessable_entity
    end
  end

  def index
    @images = Image.order(created_at: :desc)
  end
end