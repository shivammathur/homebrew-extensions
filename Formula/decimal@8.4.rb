# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "787d44f8f75040d694c44050d8575c22b012da1e388325f83018698416a8c17d"
    sha256 cellar: :any,                 arm64_sequoia: "4ddf9939a58115ef6efaa0ab21ce597860c91452e74a6ea9e85f0b1f6bf835e9"
    sha256 cellar: :any,                 arm64_sonoma:  "86466a71cf1a036f99f05b46772c6e76a201aaeb303d2f58ff2a2c4e99370482"
    sha256 cellar: :any,                 sonoma:        "24286e950aaad2e225a81afbf60b258e55a78f240e957fc81f83621ab06b6f42"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2ed0fd458099b7f86be28ddc85f85a5974f28eab8965a6738414ecff62324c33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "01aac8217189d79bc23093de72ce7b388be62f5c0d611303dc0b29b9ece9365b"
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
