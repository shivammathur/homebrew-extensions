# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT83 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.3.tgz"
  sha256 "168bdcc445e1557b889df5e46313825f2abc77c5d7cfb7a4215063d2f7ca4a97"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "01eb4f1817275c8e182eb0b73ae669aa5c234a3cd2cba8e6e267d9b5d49a3b48"
    sha256 cellar: :any,                 arm64_sequoia: "cda5af992e2dd8cfccc8577f51f65d3f72613f93a49c37b2f13c66f44862b1b0"
    sha256 cellar: :any,                 arm64_sonoma:  "959de84fde583742033d09e533bb3ba648a29177686ae801e2781dfceeae5e80"
    sha256 cellar: :any,                 sonoma:        "b08259a29d2275f0d60258972d17ed0a2e0ce6bbb68d73f99672243d44d3e348"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d3131df814737515813302af525720e2c387a28b042b65e20a16d1807b66cf41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d60a5b6cf868964ca5ed353f1c96d0f1478a88c1b4b2b8268c0a4b725d5b0c7e"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
