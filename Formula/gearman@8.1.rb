# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT81 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "c18e1bf2a6fa352a856b5ed54b4183df2530912964bd6d9582578c5dedb51fc6"
    sha256 cellar: :any,                 arm64_big_sur:  "714c281fbacd0cd8dd205f4f97a9b34ba1455906bf8a0c4d7a91fd4c95bcd05b"
    sha256 cellar: :any,                 monterey:       "4cb85f15d2b94fad163670c13eec1e1b651917429cf8d4b9556b09bc58a87879"
    sha256 cellar: :any,                 big_sur:        "cdd8a44bb0b2641830b49d337c1d807282b086f961bf63409bf5ca212d49b43b"
    sha256 cellar: :any,                 catalina:       "776d4d47c9f2c62a8ed8d637d96a813a54641cdf4debca1fa4cc15f0c14102db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0337d6942370521d783edf63895a2d97447da73cf7eb584fb3f683d85d33bdc3"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
