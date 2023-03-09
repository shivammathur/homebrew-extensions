# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.1.tgz"
  sha256 "5ce7d9be892c8ded97f8ac6009a7e3ca2f95550c615f6735a34d5d7c8b736d74"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9efaa28d8bc7c52c00a2296943977c6aba42f12b86f49026c2bf1870f128aeec"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "8f23af750c6f6f1cc1db4856ceb763b3db1e0de3693697404263211d0ea93880"
    sha256 cellar: :any_skip_relocation, monterey:       "add9d0a894398991a0e7a940cdbdddd0f281d6e9996578a7ef4207640750b293"
    sha256 cellar: :any_skip_relocation, big_sur:        "d8163dcc67dadff2db83a41d41fbda9b0fc521a73a2c90c0e805a18fa4715bc4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5ed0ce4db9ed716e819b37611cefbae92906b80ba76e9c0aea97c592771f0101"
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
