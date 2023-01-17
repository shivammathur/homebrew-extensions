# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/vips@7.1-1.0.13"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "fc33f9232b0f84ba80e7acf53f976679a4971b80036f19e38382db3ee05e8335"
    sha256 cellar: :any,                 arm64_big_sur:  "ae8e11dbfc6b640cc4a7a923b29124ce0aec058bd12523f744e8f6a48bc9f202"
    sha256 cellar: :any,                 monterey:       "96094fe0fd4ceb9f71954c75a94bfc0fdff6fc0e498fb1ced27405aa17186058"
    sha256 cellar: :any,                 big_sur:        "37a438e5ad391e05bb7fcf4972a9e5716f59948834a2814f2dc36fd84c113546"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1023f158783df74dc55f30df6208c2e6575e4d2e60d2d00ff6ca5c43e8a4656b"
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
