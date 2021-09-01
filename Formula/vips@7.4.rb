# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_big_sur: "637d1297630035d1632059bddd828ddc24e6d2255faf6bf11c3fb8d2a765abfb"
    sha256 cellar: :any, big_sur:       "a20824df88b5f1c522c0cc89ef9c0891523e4a16e9dc27434af302a0a252116e"
    sha256 cellar: :any, catalina:      "05a90806b0155273cc632459d880c54ac16e76ba58c321f29799e5b299f5ff46"
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
