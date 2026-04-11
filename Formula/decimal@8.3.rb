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
    sha256 cellar: :any,                 arm64_sequoia: "1750a9ce961abb7b8f93946b31e741bf9e7e76a819835674bca947c3b2d0c59d"
    sha256 cellar: :any,                 arm64_sonoma:  "d4e5140fb375f5dfd6704b03c17e948bb9bdde2735dbefbd8b971e9264f78bcf"
    sha256 cellar: :any,                 arm64_ventura: "5df78526ba465c528c3a29502bbcc1d3f8d71bef1dd5ccafa034a205b7990691"
    sha256 cellar: :any,                 sonoma:        "fcd9d1c9f1497b50b4cc7ad6107c8facccea5a529f66f34ebbd85bfe73a9f9f9"
    sha256 cellar: :any,                 ventura:       "5b0001e6dace40a51f4d5cb0d61fa0d07094e712674a1ee63b17ab5cd8d0882e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aa5407157f36b3b35b5ff3e32764f6b6ae6056548a0298705f457eb553c64adb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94be0a91f52578fe6db9c0df91c868145ecea98e92a7082255a02502f907362d"
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
