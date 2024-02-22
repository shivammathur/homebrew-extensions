# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sonoma:   "3a5baa370ffe5833ec82466dca8266d62c9bbb460916a60751e12be7df3e6af1"
    sha256 cellar: :any,                 arm64_ventura:  "e13db77596b909017a510268879b15f88ce3ea9e339d4a4bfff287a05ecd419f"
    sha256 cellar: :any,                 arm64_monterey: "32f944fc6ad9a3d4592f1b0845ef1b9a12eac286b4c64459127539570a6c6c5e"
    sha256 cellar: :any,                 ventura:        "d2b0db01d48e4756efbe2617c5d13d6c5e141ddfe46b1013dd03a4e15809c5c7"
    sha256 cellar: :any,                 monterey:       "6365b38a68a237ba90ae551a2579cf862227b03966a22acf7a50892aeffd936f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "363bcc4478b39d144b0fcbec11b978bf64e8dbbb3fb62d4599f908d58bc5cbe1"
  end

  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
