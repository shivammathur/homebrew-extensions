# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "197c26a30277454d18528c5aaee81914e5fd809fb349424f9c4d59f6cc907bd0"
    sha256 cellar: :any,                 arm64_sonoma:  "bc5227c3985ad1393a38f2787e59322eb047afac5616746793f647026cba8935"
    sha256 cellar: :any,                 arm64_ventura: "8270d4f28db12c63a35db76bc3f45458e9c819d2967154a2fe10ccbf8b8397e5"
    sha256 cellar: :any,                 sonoma:        "91b9ab7921a25b3b3abc2444681f2f92655735fbd3a7827f7684f0cf2fb36f68"
    sha256 cellar: :any,                 ventura:       "04113fd1efcee7bfee9205ac41d6250035b6fa0ccdf9da79d61632edd24466c2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "68fcfb3c2c5e28691416d89752fc65fb331efdabdc1d412531555cc5853e61db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b11d327e43ee77a1789307f6133c819e4593c796e7a6d2280bcf724d5a7b8cb8"
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
