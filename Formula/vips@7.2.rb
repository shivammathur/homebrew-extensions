# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "4669f814b3254526aaf62d597b0b1ca1734f68cab7b681bafecb52800f0f6303"
    sha256 cellar: :any,                 arm64_monterey: "f8a619f94e110a6a46d4d695a00467e5caeabd6589f661ce1a3faa88b88cdb78"
    sha256 cellar: :any,                 arm64_big_sur:  "cb7671c0313bde233a75d63f0f547571b85fe5db98b38f66e9c8a73905690f45"
    sha256 cellar: :any,                 ventura:        "7af183d52820be325885f66c739b973ddb73d2248fc577eb330f63268d0fa64e"
    sha256 cellar: :any,                 monterey:       "9faa77bf754b810f883b5574f54d99e1b5bf6ca9b6a5d79bd6b091fc05683b44"
    sha256 cellar: :any,                 big_sur:        "c7abff08a162436b7f22e2935d9bf7010629b914a9af3b7b64cec2ed52426a5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1f82357ea3d5ec148c5bf6c4afbca5e62fc8932e7cbd62ba5fdb1b59c091aa22"
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
