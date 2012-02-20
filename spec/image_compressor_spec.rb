require 'tempfile'
require 'fileutils'

require 'nanoc/filters/image_compressor'

describe Nanoc::Filters::ImageCompressor do
  
  let(:gif_path) { File.expand_path('../test.gif', __FILE__) }
  let(:jpg_path) { File.expand_path('../test.jpg', __FILE__) }
  let(:png_path) { File.expand_path('../test.png', __FILE__) }
  let(:run_options) { { :pngout => false } }
  
  before do
    item = double('item')
    item.stub(:identifier) { '/test/' }
    item_rep = double('item_rep')
    item_rep.stub(:name) { 'image' }
    subject.assigns[:item] = item
    subject.assigns[:item_rep] = item_rep
  end
  
  let(:extension) { path.sub(/^.+\.([a-z]+)$/, '\1') }
  let(:output_size) { File.size subject.output_filename }

  context 'jpg image' do
    let(:path) { jpg_path }
    it 'should compress' do
      subject.run path, run_options
      output_size.should be < 300
    end
  end
  
  context 'jpeg image' do
    let(:path) do
      file = Tempfile.new(['test', '.jpeg'])
      file.close
      FileUtils.cp jpg_path, file.path
      file.path
    end
    it 'should compress' do
      subject.run path, run_options
      output_size.should be < 300
    end
  end
  
  context 'png image' do
    let(:path) { png_path }
    it 'should compress' do
      subject.run path, run_options
      output_size.should be < 1900
    end
  end
  
  context 'gif image' do
    let(:path) { gif_path }
    it 'should compress' do
      subject.run path, run_options
      output_size.should be < 400
    end
  end
  
  context 'text file' do
    let(:path) { __FILE__ }
    it 'should pass through' do
      subject.run path, run_options
      output_size.should == File.size(__FILE__)
    end
  end
  
end
