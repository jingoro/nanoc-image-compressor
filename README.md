# Nanoc Image Compressor

[![Build Status](https://secure.travis-ci.org/jingoro/nanoc-image-compressor.png?branch=master)](http://travis-ci.org/jingoro/nanoc-image-compressor)

A [nanoc](http://nanoc.stoneship.org/) filter that compresses `gif`, `jpg` and `png` images losslessly.

## Installation

### 1. Install the gem

Add this line to your site's `Gemfile`:

    gem 'nanoc-image-compressor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nanoc-image-compressor

### 2. Install the binaries

This gem uses the [image\_optim](https://github.com/toy/image_optim)
gem which depends on binaries being installed (`advpng`, `gifsicle`, `jpegoptim`, `jpegtran`,
`optipng`, `pngcrush`, `pngout`). See the [image\_optim README](https://github.com/toy/image_optim)
for instructions on how to install these binaries.

### 3. Add a `require` statement

Add this line to your site's `lib/default.rb`:

    require 'nanoc/filters/image_compressor'

## Usage

Add a filter within a `compile` block in your site's `Rules`:

    compile '/images/*/' do
      filter :image_compressor if item.binary?
    end

Any options will be passed to `image_optim`:

    compile '/images/*/' do
      if item.binary?
        # we don't have pngout on our system
        filter :image_compressor, :pngout => false
      end
    end
