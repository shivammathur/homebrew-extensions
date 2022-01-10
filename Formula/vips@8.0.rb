# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.12.tgz"
  sha256 "c638250de6cad89d8648bff972af5224316ccb5b5b0a7c9201607709d5385282"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "c1320e13a8bc5314e13c766db208296f9568a538140ddbb9dba6b888c104d4c8"
    sha256 cellar: :any,                 big_sur:       "63e7452e1b5766b3afeaaa4c61283ae54f7e93155077b0f47ecd392de8477f72"
    sha256 cellar: :any,                 catalina:      "a0ddb98bf9ddb644cb4cbe09e52db03d7bebde50b6fc1e4a8109cd11c6997238"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec13bd02830b3796de5e904adc78f3f2224f6320aae1d3f49c7d3375e2c3b9f6"
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
