# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 big_sur:      "88109de19762c77020ef9495b8bbb52e508db45d5aa47da5dfcff0fd1cf6824a"
    sha256 cellar: :any,                 catalina:     "5234c5416741b9399d04ec0af9ebcddb29e13ab449f4f39da8f350851e04bc0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3854a299a0e84bd3317a4ce4d4b9572a5baed4d01ced254d44a78ed987636e10"
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
