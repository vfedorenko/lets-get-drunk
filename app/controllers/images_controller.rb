class ImagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @uploaded_io = params[:image]

    @response = Cloudinary::Uploader.upload(@uploaded_io.tempfile);
    @image_url = @response["url"]

    p "url = #{@image_url}"

    # File.open(Rails.root.join('public', 'uploads', @uploaded_io.original_filename), 'wb') do |file|
    #   file.write(@uploaded_io.read)

    #   p Cloudinary::Uploader.upload(file);
    # end
  end
end
