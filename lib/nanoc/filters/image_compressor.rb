require 'fileutils'
require 'image_optim'
require 'nanoc'

module Nanoc
  module Filters
    class ImageCompressor < Nanoc::Filter
      
      VERSION = '0.1.1'

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
        # ensure the output permissions match the input
        in_mode = File.stat(filename).mode & 0777
        out_mode = File.stat(output_filename).mode & 0777
        File.chmod(in_mode, output_filename) if in_mode != out_mode
      end

    end
  end
end
