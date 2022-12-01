# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.2.tgz"
  sha256 "750712956179f296d68d4d022e223955d1e534ea32672c2d7875f2611920a2b6"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c7daf50d0b407a7576dc986d16e40bf9dec808ca73f476b8e77f3b6b84c90c79"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "07d91100b5852e84e5d058fa3a3d16d2d4212fd534b194d4b91c5330694640ea"
    sha256 cellar: :any_skip_relocation, monterey:       "16c229738f0ac5c8a0709eb0fae5841fcc41c5b7419c011d19f99a1cdcd1e091"
    sha256 cellar: :any_skip_relocation, big_sur:        "ca819a366f6c20fa92a11fe6a978ddc9ded4b28df34d005e581dfdf8a4c70e61"
    sha256 cellar: :any_skip_relocation, catalina:       "1db7410db6934ba7591487d2dd7a326e8348b3c925076f5bd3c4fd7adae75217"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1ce58bf62480ec5857d13a7767d9dcc4538aefb4defbd07e4facae0d690949f9"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
