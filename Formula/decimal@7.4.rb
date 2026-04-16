# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT74 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.3.tgz"
  sha256 "168bdcc445e1557b889df5e46313825f2abc77c5d7cfb7a4215063d2f7ca4a97"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "0bbbbd79f1af137e08139cc4403aed3476723593d0622eb082cc750a72b17edb"
    sha256 cellar: :any,                 arm64_sequoia: "3509f3335fb5c91209836ae8b2fca4442caa543079aaebfe4b7f625c0b0ebfaa"
    sha256 cellar: :any,                 arm64_sonoma:  "72e94682273f62a7f977e6e12e5260d780bff10a22f37ac072827b3e00f8bd26"
    sha256 cellar: :any,                 sonoma:        "52a8fd6c800f392804570aba2f1cbcc169406a82e51d49d670d23ee799472f4e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "339e34aff5d08b79333ccfff880be3f917db7758e218d50e195fe3bdf632aa1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b97427aa7e10d3f3796c16349f2ea1cbdec4fe1d1f0916c72de650ffea43e3c7"
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
