# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "b0ce635ce7e1daf87289dfbe486b1b21986c6f251d5941d6a891ad50e869d03a"
    sha256 cellar: :any,                 arm64_big_sur:  "6e06bbd52436538e8fd140275ffdb30dceb101b803b77bfd95f2aca4349f9962"
    sha256 cellar: :any,                 monterey:       "de940b8a4b86db6f2118b7b2ea42d37d13878511fced63f36a09c5743cc9c112"
    sha256 cellar: :any,                 big_sur:        "e03e691f7f2aa8bb447b525f20c425e1bf196092e0d0696a77580aecb5cf189e"
    sha256 cellar: :any,                 catalina:       "e45858e98796888aad1db45b849a782e270731ed5056dc419e184b91937ff334"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "52492f51019c3bbfa83467e5567a2264d7b63b787332d8669fde02b0f685ce83"
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
