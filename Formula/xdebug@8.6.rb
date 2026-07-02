# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/6e86e8602ddacf3f7473c3bd14c0c8b57d64c10c.tar.gz"
  sha256 "c9fc5d2f423bc32f6651f4ad3155d3ccb2c396af07cec333a5c7dd00d897d52d"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256                               arm64_tahoe:   "f92070ead47214554a40ff8d1e311ba4ab8a747cc214e58aa431e404c6e73382"
    sha256                               arm64_sequoia: "d4adf6ec3cf2d23276679cf67582f1c07c553f2bcfc599267590f60d85b15f41"
    sha256                               arm64_sonoma:  "e9ebee58069f73cca4d6106ec49d0dea6b8461187a0ee2872390a8e23c6edd7f"
    sha256 cellar: :any_skip_relocation, sonoma:        "81af252a6e17718b6ab6a8d5092828779c778b8147c7063d62797c17d1c2f162"
    sha256                               arm64_linux:   "b2cc026d584970e3851b8dfae1b07957e08373abf31d17f6f5b42e161538ed6b"
    sha256                               x86_64_linux:  "2de61d550178851126613b2add1d176c5e1c2efff9450db10c2e67ec223898ab"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
