# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.0.tgz"
  sha256 "417a0b39acebad34608d33ba88aa0ddc0849d45a7e4f107c1e8399f50a338916"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8ec3ea4ac031883adcf37a085fb3f25f196f9895cd3c805c5f5461157e6ce44e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d4d629a9bf2aa1b05ac10728c91f23973e245a7db83ccb151472d43a242f9025"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7ff2f3a4e8986d6e62c1cfa995f5b89c009a679c74818483f8be50e549393cbc"
    sha256 cellar: :any_skip_relocation, ventura:        "a8f9d2229d255e339441d7d1ab2b5c45cb3c2a199899f4b4b4eedc91761db92c"
    sha256 cellar: :any_skip_relocation, monterey:       "9ceec32775425d5916ead9b744f75ab1fabdd78fa4af54215f722503cb61310c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2e6828caff9d7ec0e87a37aab949e1f45dc9ccc9a71442d8a5c32b00db1c8894"
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
