# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT83 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.3.tar.gz"
  sha256 "954e56021668121ecc50b92d2ad1ce945f22ecf81ffc5bb5835219485b12ef5f"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "7b752839b6c434cb2c03d398c7e149a78a03c7fb167eddfada1b7dce95fae0e4"
    sha256                               arm64_sequoia: "dc302832b1297c5b18d111fa4eff7d08039810396fa48beeff1f8f93a3dc8403"
    sha256                               arm64_sonoma:  "3f6a844f949e0574e9569e34eddedb7eef873f49d65d7488a0e710d83719a748"
    sha256 cellar: :any_skip_relocation, sonoma:        "cb8083ae1897da4ea92f473c3425926674fb0a841f58da21fe62044f0d983f2c"
    sha256                               arm64_linux:   "ebb63d3ecca88a6b85d5502baf863eba6716f9bc145377c6752e5d86548f44b3"
    sha256                               x86_64_linux:  "2872a2e38d6b9f40553b4e6389bdba267fac08b6e1f7b767c7b0083d40edfb39"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
