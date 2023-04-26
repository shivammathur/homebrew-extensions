# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.1.tgz"
  sha256 "5ce7d9be892c8ded97f8ac6009a7e3ca2f95550c615f6735a34d5d7c8b736d74"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "da29a03d5318c87223d4a0ca401cfd3fa02038bcf16d7c9ddf97eeb05d7efab0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7f7da8d5ca0917ba0fb6c992a3da5b175320babaadaed8ee709fd77e048423dc"
    sha256 cellar: :any_skip_relocation, ventura:        "bc1a93ee6f1f8be031ca2b1655523a26ba069bd5302de9734636a94a194367ef"
    sha256 cellar: :any_skip_relocation, monterey:       "08470b623a0a658f9c8de7800b3f4e679f5569c4045cf8fbf5dc265733a2ef00"
    sha256 cellar: :any_skip_relocation, big_sur:        "33d2e7e4470fc616ae50d8c08fb4ff04b54a17adbbc580eaabab8606d1b4ffec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f4514e87d42c6d2ab32bab6d5182475b00cff59c0ab35c7635daac709f3e804b"
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
