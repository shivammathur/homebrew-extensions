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
    sha256 cellar: :any,                 arm64_tahoe:   "3af186caa653221933b6da6c8030b4738630c1da1ae14430fe47bee1ce0de4be"
    sha256 cellar: :any,                 arm64_sequoia: "0913c70c91956f6af03c66151ca41e9db96dca05fdbcd88a530c2cb8522f7812"
    sha256 cellar: :any,                 arm64_sonoma:  "44d81e7a544dd87d841e56924561e62fdb7e080a72cf20bd65acbc63b11f3594"
    sha256 cellar: :any,                 sonoma:        "3ca8fa9fd49ebcb5e06704ad692410d796d7ed0b1eb17ac3d9c72bdb86ef0c45"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6c1990235b7fdc5d93866f509355929529e87ed3f8233055aae30660dd63d812"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eaf80ab5509db88bf28a1ea480d3686eeaf6299862a3336313873c7bcc5281d2"
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
