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
    sha256 cellar: :any,                 arm64_sequoia: "536c23b249834302f64e96498f63252fa5238f4c802d259771860b24eed0a0dd"
    sha256 cellar: :any,                 arm64_sonoma:  "6684e7e54918753e579f4fc0aa6194bdcdf2c7cb482b61d6edbf2248bc0f33ff"
    sha256 cellar: :any,                 arm64_ventura: "099512434f8b0ec1de9b1b91e873ba7ad238c15b4b7aeb1988bba1ba42ed3eb5"
    sha256 cellar: :any,                 sonoma:        "21a0412e1ae7c8c5deeb000ec192687d66a4c904a987fd093bb8935bbb65911a"
    sha256 cellar: :any,                 ventura:       "80772609292458df84c12f1114d91d1493dcdde4fcc6ea1bd54be713eb057a51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "aed2cc89661f580aa4c4b0094b4328d2f15e638b31f89bc9b4ebe0cdcfa5618b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ab829e3b5b3371a11d9a7fe4cb687706972e3afb7af92f38f94bfc0f7cc543f7"
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
