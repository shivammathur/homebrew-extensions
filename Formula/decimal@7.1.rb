# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT71 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-1.5.1.tgz"
  sha256 "8a103404e8df889f3c9626aa2668354ef1b46362071440e764765fb311b621c8"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a963cd80d0b3010ffeee75a2b401983743b59d569e6066343088f2175d1597f6"
    sha256 cellar: :any,                 arm64_sequoia: "f0f5d2d0e9d46ac451e8074ec9adf48c6ed6b823c57de8b2d16036e8ede2db72"
    sha256 cellar: :any,                 arm64_sonoma:  "c3582cfd5cb9b8abf05de6d992d47b3c6d76ca5709f1bece34034b2b87bc72d2"
    sha256 cellar: :any,                 sonoma:        "dcabdd2901c1e10c7e7e0173955c33fedd9b51a335631f6bda34b7b0d145266b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "383c97f4100651a8d94789aa454ee9bfc38d5d5633455581e04bb6f30d1d02ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "efa5df30c1c291eee7ba8e917a349e43a282febcfa8fda029d8ff8ac712d3745"
  end

  depends_on "mpdecimal"

  def install
    args = %W[
      --enable-decimal
      --with-libmpdec-path=#{Formula["mpdecimal"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
    Dir.chdir "decimal-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
