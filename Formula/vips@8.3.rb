# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4d367aa6f64b794896cb9168ce0b78ebe434b2aa0c57dddb6438f83e319a36c3"
    sha256 cellar: :any,                 arm64_big_sur:  "3253adcbad8b5f21d8c18032e909ad92e1cbf752ccd14185325693465ef7af9d"
    sha256 cellar: :any,                 monterey:       "0bc8ad9aaee291880df21f004e474a6547d02e5c17160665650b42ec334ccc44"
    sha256 cellar: :any,                 big_sur:        "1fddb3b23cf9e167daba3e8beab501d2211f5ba2b08f81c61479f9cf7c5a8fdf"
    sha256 cellar: :any,                 catalina:       "bd28426af404f3941fbe9a430486d91da515af7697a3df11cf9a752c5ce20238"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aee12a0e99f2e72cbc29ab0898b2cce91507a3b7bf84607f2f000b554194b0c2"
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
