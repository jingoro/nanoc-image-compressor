require 'fileutils'
require 'nanoc'
require 'sprockets/image_compressor'

module Nanoc
  module Filters
    class ImageCompressor < Nanoc::Filter
      
      VERSION = '0.0.1'

      identifier :image_compressor
      type :binary

      # Compresses the content with Sprockets::ImageCompressor.
      #
      # @param [String] filename The filename to compress
      # @option params [String] :type ('auto') png, jpg or auto
      # @return [void]
      def run(filename, params={})
        type = (params[:type] || 'auto').to_s.downcase
        type = filetype_guess(filename) if type == 'auto'
        content = File.read(filename)
        compressor = case type
          when 'png'
            content = Sprockets::ImageCompressor::PngCompressor.new.compress(content)
          when 'jpg', 'jpeg'
            content = Sprockets::ImageCompressor::JpgCompressor.new.compress(content)
          end
        File.open(output_filename, 'wb') { |f| f.write content }
      end
      
    private
    
      def filetype_guess(filename)
        filename.sub(/^.+\.([a-z]+)$/i, '\1').downcase
      end

    end
  end
end
