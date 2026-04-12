# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT85 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-2.0.1.tgz"
  sha256 "026e30f71016d25f267f9b38ab80a94bed4779e05e9ff5f48d9b08bf1c18d204"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/decimal/stable.txt"
    regex(/^(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f5635b569ffb7b4e3b650864f03ce7f95959fdf79e030eb9649b19f64120ebd5"
    sha256 cellar: :any,                 arm64_sequoia: "e38bb0008054ee05c23b80b914c29c75bfed8faf125b5dc5c7e3ab77c34938b1"
    sha256 cellar: :any,                 arm64_sonoma:  "41b57a09efe817502d6b7e2be442f7712da8c7c8d4fe1ef67ad379281d16935a"
    sha256 cellar: :any,                 sonoma:        "76c62d558e81b7ff2c89a8d5e9daa8be60eefb6e59ef1080bef4b0eacba32ba7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f7a056eee1e0a30af29766a9673b5216c9a23d3a3ea7fcf34543524217a9c74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddaffdc6cb77ab828dbee284d5235b0fb71f2c19fbcaa6649ede395c506ee38b"
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
