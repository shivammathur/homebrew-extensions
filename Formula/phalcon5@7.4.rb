# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.5.tgz"
  sha256 "860e4fa67073a551c67b412ff0108306f01c5512b1e6c2192128c7ef02a3c83d"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "170620f670cc2e0971521c6c57ad8ea18b148825a94b7d42171ace508f253c70"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cf77d03446f910d676242ecd9bee66c26112f263594663c9bf788d9e87750b1a"
    sha256 cellar: :any_skip_relocation, monterey:       "9b9adc7ff6861524e2d30cde887033ccebcafd413a4bee32b6cc7ae726c4be8a"
    sha256 cellar: :any_skip_relocation, big_sur:        "9f84a36c6a1657ffb66f5f2e4f2c8d06d3289f884784dcfd9397eecc1e6d33aa"
    sha256 cellar: :any_skip_relocation, catalina:       "274dba4e3c73a0ce0b0ae30224d6c69c15fa75b0b0a79fc42fa531fa22dae7fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e40a7dd67ad9a38f8c041b51ac75d67d6a123ff7580e9815688fb9846324986c"
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
