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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dc6bc5af572577fbcfd2f86bff7bff431d11508d0785ac22892da245a3029f30"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e08163a4767caac1c57972dd9ee8899227489959b6593e71ed1e5617f45337d4"
    sha256 cellar: :any_skip_relocation, monterey:       "917e57b44f871a294193362480ab989e75dea89f9146d23b2e5c10f5513cceed"
    sha256 cellar: :any_skip_relocation, big_sur:        "a15f67701eb9d0bc937a7dccf648f626e6f1290b27d5ec5f347f1319ed197fd8"
    sha256 cellar: :any_skip_relocation, catalina:       "50a6d71b0e7dbfe063a78595f7e6deb027985898b69d92b315449443757f42a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "31059fe7d0c3cb6b1e3f1ee8b8e5057f6a66d4a79945c80bd6d92de677617859"
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
