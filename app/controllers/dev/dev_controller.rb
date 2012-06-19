require 'kss'
require 'sprite_factory'

class Dev::DevController < ApplicationController
  layout "dev"
    
  def index

    @styleguide ||= Kss::Parser.new("app/assets/stylesheets/dashboard")
    # raise @styleguide.to_yaml
  end
  
  def schema
    
  end
  
  
  helper_method :styleguide
  
  
  def sprites
    
    folder = params[:id]
    folder_versions = {'icon' => '1', 'icon_16' => '2', 'icon_32' => '3'}


    stamp = Time.now.to_i
    
    icon = ''+folder+'_sprite_'+stamp.to_s+'.png'
    
    spriter = SpriteFactory.run!(
      'app/assets/images/icons/'+folder+'', 
      :library => 'chunkypng', 
      :style => 'scss', 
      :layout => :packed, 
      :nocomments => true, 
      # :report => true, 
      :selector => '.',
      :padding => 1, 
      :output_style => 'app/assets/stylesheets/sprites/'+folder+'.css.scss', 
      :output_image => 'app/assets/images/sprites/'+icon,
      :csspath => 'sprites/'+icon
    ) do |images|
      # raise images.first.to_s

      css = []
      
      css_classes = []
      images.each do |image_name, image|
        image_name = image_name.to_s.strip.downcase.gsub(' ', '_').gsub('-', '_').gsub('+', '_').gsub('__', '_').gsub('icon_', '').gsub("/\s*[^A-Za-z0-9\.]\s*/", '_')

        css_classes << image_name
        
      end
      
      css << "// Icon Sprite: "+folder+"
//"
      css_classes.each do |key, value|
        css << "// .#{key}  - ."+folder+" .#{key}"
      end
      
      css << "//
// Styleguide 10."+folder_versions[folder.to_s]+""
      
      
      
      css << "."+folder+"{ display: inline-block; vertical-align: text-top; background-image: image-url('sprites/#{icon}'); background-position: no-repeat;"
      
      
      images.each do |image_name, image|
        image_name = image_name.to_s.strip.downcase.gsub(' ', '_').gsub('-', '_').gsub('+', '_').gsub('__', '_').gsub('icon_', '').gsub("/\s*[^A-Za-z0-9\.]\s*/", '_')

        css << "  &.#{image_name} { width: #{image[:cssw]}px; height: #{image[:cssh]}px; background-position: #{-image[:cssx]}px #{-image[:cssy]}px; }"
        
      end
      css << " }"
      css.join("\n")
    end
    
    # , :nocss => true
    
    redirect_to '/dev', :info => "The CSS Sprite has been resprited for the folder "+folder+""
  end
 

end
