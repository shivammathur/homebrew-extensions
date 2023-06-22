# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.2.tgz"
  sha256 "787acbddd81b7f8da4771928a6359d59fe9010c980e9de25a59d3efb2d50437e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "aa0acedf5152aff48585da632b924d2056a0bbb024a3f208be05117c1614e27b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0d1161c082280d5d91856cd32b260e1eb1f8b359d9e271da3ec11e243f7409f8"
    sha256 cellar: :any_skip_relocation, ventura:        "7a3cb26170450305d855c11638bd2e91e853b9c1b54c27e28dddac5c9e4c0024"
    sha256 cellar: :any_skip_relocation, monterey:       "e345b47b4c93620851feca547e3323a37be3a65d9aa6c5c6a2cf12a06bedeeb9"
    sha256 cellar: :any_skip_relocation, big_sur:        "d2760b38115b9f1e9ebc2b86e98c1b9e6c67fdcee31c1240b47055a6e3fb63ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b712bb49affceeea50c45ee2a116b2fcbe292cd48e2b95604756311dcb25de6"
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
