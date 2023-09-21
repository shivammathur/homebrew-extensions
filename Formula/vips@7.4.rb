# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "b545f68b5f9f4870fe12ae89d96cf7aff2e3adac2497787e8afe45f7949258b4"
    sha256 cellar: :any,                 arm64_monterey: "a100ae0a0d7175c0b5ff0f6800c0c4b58a6bed1348c0f6502c4225d0ea77977a"
    sha256 cellar: :any,                 arm64_big_sur:  "039524c7f1419d7bab92316bd360ed1aa2569826bbb0e059877367f7bb64cd1f"
    sha256 cellar: :any,                 ventura:        "124a016d2a4d4328f4c9b23fe97e416136548a7422632bdc5daf45bf6a05ec84"
    sha256 cellar: :any,                 monterey:       "81fadad59218c65b17e0b5c4b2032c245d8cff75f3a350a6643f2798cb57c689"
    sha256 cellar: :any,                 big_sur:        "10b113e357a398a6a3a79dce748f4562316f8c2e9f9ee21556fa35fa1bf836d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62ca1ddf6aa3ecca3da17caaedcea102ad94c6ece514a5a9b94ea9c1d59f915f"
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
