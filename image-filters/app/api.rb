not_found do
  'This is nowhere to be found'
end


get '/v1/default/*' do

  # render_image params[:splat], resize: => "200",
  #   crop: => "200x200+0+0",
  #   quality: => "80",
  #   strip: => ""
  params
end


def image(url_or_path)
  if url_or_path.match(/^(https?|ftp):\/\/[a-z0-9-]+(\.[a-z0-9-]+)+(\/[\w-]+)*\/[\w-]+\.(gif|png|jpg)$/)
    MiniMagick::Image.read open(URI.parse(url_or_path)).read #Net::HTTP.get(URI.parse(url_or_path))
  else
    MiniMagick::Image.from_file url_or_path
  end
end

def render_image(image_path, options = {})
  given_image = image image_path

  expires 2*365*24*60*60, :public
  content_type "image/#{given_image[:format].downcase}"

  given_image.combine_options do |cmd|
    options.each do |name, param|
      if param.nil? || param.to_s.empty?
         cmd.send name.to_s.strip
       else
         cmd.send name.to_s.strip, param.to_s.strip
       end
     end
  end

  send_file given_image.instance_variable_get('@path'),
    :disposition => 'inline',
    :type => "image/#{given_image[:format].downcase}"
end