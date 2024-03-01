# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "ecaac8cafbe4baa5052f8da4865318e52ff87c0773aba6338809c2be38f0cc92"
    sha256 cellar: :any,                 arm64_ventura:  "73ac2c3c49584725019128b598d3c5e249b512a263a94a99f74d5d1530451944"
    sha256 cellar: :any,                 arm64_monterey: "7bf5ef666975219d2a0bf7485047710d81dd745952390620dc5827f78eeacda1"
    sha256 cellar: :any,                 ventura:        "472b2732c53f7216bc6bf282ca874f4ecdfdba56646fb8f383fc242150558c19"
    sha256 cellar: :any,                 monterey:       "f342f49e2f3b52ea9f39f6b9ae0d2be33e7ada6292d25e715790c0e5268ae243"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0e74a9c7b6bd0a3172401c6c361d611b5fb2eb3caabaa41571db93238e572660"
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
