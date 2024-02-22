# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sonoma:   "4d368ef0aa486e8a80a65e25959eb07e0317f44212814f2331eef6953b18e32f"
    sha256 cellar: :any,                 arm64_ventura:  "38f5582185794fc30bba7e9af5be5124340d3025bb1cd6018b4d2f085886b35d"
    sha256 cellar: :any,                 arm64_monterey: "149082fce58e05414f68a06281430f9613892b9aa274d563cdc8337f3526bdb4"
    sha256 cellar: :any,                 ventura:        "604ae2cf0fabb1c3a177261aa707a70efa5ed7c4af72876dd25d3675c1c9e831"
    sha256 cellar: :any,                 monterey:       "ba870d098e290f038916e42d20fb5d1d4258028709c2198b64190996812ce9f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a605a8d1e7cd2ad62da3aaa35dfef1804f5099fa089f1806b7c6f04df9868050"
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
