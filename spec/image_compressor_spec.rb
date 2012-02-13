require 'tempfile'
require 'nanoc/filters/image_compressor'

describe Nanoc::Filters::ImageCompressor do
  
  before do
    item = double('item')
    item.stub(:identifier) { '/test/' }
    item_rep = double('item_rep')
    item_rep.stub(:name) { 'image' }
    subject.assigns[:item] = item
    subject.assigns[:item_rep] = item_rep
  end

  def self.it_should_filter_implicitly
    it 'should filter implicitly' do
      subject.run path
      File.read(subject.output_filename).size.should == expected_size
    end
  end
  
  def self.it_should_filter_explicitly
    it 'should filter explicitly' do
      subject.run path, :type => extension
      File.read(subject.output_filename).size.should == expected_size
    end
  end

  context 'jpg image' do
    let(:jpg_path) { File.expand_path '../test.jpg', __FILE__ }
    let(:path) { jpg_path }
    let(:extension) { 'jpg' }
    let(:expected_size) { 285 }
    it_should_filter_implicitly
    it_should_filter_explicitly

    context 'jpeg extension' do
      let(:path) do
        file = Tempfile.new(['test', '.jpeg'])
        file.write(File.read(jpg_path))
        file.close
        file.path
      end
      let(:extension) { 'jpeg' }
      it_should_filter_implicitly
      it_should_filter_explicitly
    end
  end
  
  context 'png image' do
    let(:path) { File.expand_path '../test.png', __FILE__ }
    let(:extension) { 'png' }
    let(:expected_size) { 1814 }
    it_should_filter_implicitly
    it_should_filter_explicitly
  end

  context 'gif image' do
    let(:path) { File.expand_path '../test.gif', __FILE__ }
    let(:extension) { 'gif' }
    let(:expected_size) { File.size(path) }
    it_should_filter_implicitly
    it_should_filter_explicitly
  end
  
  context 'text file' do
    let(:path) { __FILE__ }
    let(:extension) { 'txt' }
    let(:expected_size) { File.size(path) }
    it_should_filter_implicitly
    it_should_filter_explicitly
  end
  
  def output_size
  end
  
end
