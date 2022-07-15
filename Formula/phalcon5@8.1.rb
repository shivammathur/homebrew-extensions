# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.0RC3.tgz"
  sha256 "e83643078d59b7ba39fa7dded2f0d95abf0c872a85599538ed4214f58acdce40"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1c4eb82f3234672698db37b583c756327014547d8e9840ba0835d3ca5f888169"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5ae85d310b0896eedf38f6aa82822c50333047b1b73948d6b81c10d0435e29da"
    sha256 cellar: :any_skip_relocation, monterey:       "8e5bc5b9762ab29b236535147788bf111e4760b2c3b41f369a9ba4b24e80e56c"
    sha256 cellar: :any_skip_relocation, big_sur:        "3a15e6817ab4b90e5da1b58eb0e5a3064e03daa5ecba8778c0af58a773cb78a4"
    sha256 cellar: :any_skip_relocation, catalina:       "1d0ff811f5b1a20fababd3da4f33ddbcda80e33608195e785050fc86236225cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "680aba3e739bbec439d014cdd8e47463a553b55c55056aa358a6a8d5d2d14cce"
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
