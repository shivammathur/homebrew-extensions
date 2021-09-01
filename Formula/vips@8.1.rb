# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_big_sur: "21d4a750b19aac44f1e763838252068a4d98b18ffed6ae4bd11b5805c7403b0b"
    sha256 cellar: :any, big_sur:       "e93fb6e669b4f21919d9266879773b5d76c7cbf63090a3e6f6dcc5fd208e9485"
    sha256 cellar: :any, catalina:      "fc31b1c1d614d8a99db4983149bbd3170ae71845c58a0cbcfee954f3ca5f3cde"
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
