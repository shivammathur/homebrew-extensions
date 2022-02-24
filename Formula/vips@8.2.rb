# typed: false
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
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "9e95b6466bf82c03ff40fea2949af07204a8b47eec96ac69cac6c877abe46d65"
    sha256 cellar: :any,                 big_sur:       "521b3f250c8f3018f4e1fcdf6fa9fcfed752e4570df3226210fc39ffb440de38"
    sha256 cellar: :any,                 catalina:      "5508684dc4d4f17ef8ffe7bb9cbb5a4f862c515a2bba319b8b12511951a5d9bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eab3ba921b55534dabfcf814d2bda2f396b0b40da988c79438f1a3b7999b0b64"
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
