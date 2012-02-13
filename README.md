# Nanoc Image Compressor

A [nanoc](http://nanoc.stoneship.org/) filter that compresses `jpg` and `png` images losslessly.

## Dependencies

This gem uses the [sprockets-image_compressor](https://github.com/botandrose/sprockets-image_compressor)
gem which depends on [pngcrush](http://pmt.sourceforge.net/pngcrush/) and
[jpegoptim](http://www.kokkonen.net/tjko/projects.html) being installed.
As a fall back, the gem includes 32-bit and 64-bit binaries for Linux.

## Installation

Add this line to your site's `Gemfile`:

    gem 'nanoc-image-compressor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanoc-image-compressor

Then, add this line to your site's `lib/default.rb`:

    require 'nanoc/filters/image_compressor'

## Usage

Add a filter within a `compile` block in your site's `Rules`:

    compile '/images/*/' do
      filter :image_compressor if item.binary?
    end
