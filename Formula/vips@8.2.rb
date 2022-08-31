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
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "1f6b7a67332a36b49c0c6ddf296dad4147e5c0a7b870955b78bd055005a9b8bf"
    sha256 cellar: :any,                 arm64_big_sur:  "c9372243d898150a00130a1c839ee2b79dd7777d6e4aa8ca96ef7456d47a570c"
    sha256 cellar: :any,                 monterey:       "1c4dd59c9a34fdfbbdc6f6546ac30b5f6defb1d334753707e5cfb61f2e4dc019"
    sha256 cellar: :any,                 big_sur:        "da433005960d10ff2d1c59233227639e680f187db3861bde3445edc3c14191e3"
    sha256 cellar: :any,                 catalina:       "05790395b6d3381b8393508bcf7d5e48e1dd321ff48c55c237cd1be68f8b8045"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3bbde6144f4840f0c504c05228da52df5a61e87af230f48c214cc11db30289f9"
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
