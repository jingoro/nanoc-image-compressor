require 'fileutils'
require 'image_optim'
require 'nanoc'

module Nanoc
  module Filters
    class ImageCompressor < Nanoc::Filter
      
      VERSION = '0.1.0'

      identifier :image_compressor
      type :binary

      # Compresses the content with Sprockets::ImageCompressor.
      #
      # @param [String] filename The filename to compress
      # @param [Hash] params Passed through to ImageOptim.new
      # @return [void]
      def run(filename, params={})
        io = ImageOptim.new(params.merge(:threads => false))
        result = io.optimize_image(filename)
        path = result ? result.to_s : filename
        FileUtils.cp path, output_filename
      end

    end
  end
end
