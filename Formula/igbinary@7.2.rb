# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a0ae5d58a15dc96f4076b4a66c0f089bf241f6594a73cbd29a149b1cd9354d66"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3f1b083ce61d03138a93894d1cc2c5d78ef35e22c821b975f2cd17fddd16fc25"
    sha256 cellar: :any_skip_relocation, monterey:       "5be99a2006f542dad8113e9c756cfa0d076f12f263cd5f7fb2bccfd07c46d6da"
    sha256 cellar: :any_skip_relocation, big_sur:        "183e707ad72519227d992738f54ba4f6bb9af397f9c7ceabb532de8ee7782a49"
    sha256 cellar: :any_skip_relocation, catalina:       "9ed12aa59580bf2db47c9cec33c55eb72817d66e1ca022a86466908424cc4c29"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "39d6190b24ace7aa90bf5787077f44db09de3b77d63a22b03ca548efbe4f61ec"
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
