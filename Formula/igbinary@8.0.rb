# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c079bbbd1771fd395d5218ad6952c2ef7219fdba10fbdbf04c3d1d7c6787b8e8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5f17a7dfbafc348d4815c3c056e46d6b9d1ca9ef59150d523a5924d61d549c77"
    sha256 cellar: :any_skip_relocation, monterey:       "fec2d7a9c9a4d5148ee97cb212b936a72c5f2fdd78685ac109a796e75c6640c7"
    sha256 cellar: :any_skip_relocation, big_sur:        "8cd02a86ad7ca57f086f2ec7c1479dcdf51993adfdef030a7344a1bf632bd455"
    sha256 cellar: :any_skip_relocation, catalina:       "76684ed2c2c907bc306c1eb3c734ed61a8277b1943d0e0bbb91bffaa0dcc3d12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7381540734ccfae31cf285fa404009494d37e281247dc3ffcb8f12faef8c973a"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
