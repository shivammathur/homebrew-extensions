# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT80 < AbstractPhpExtension
  init
  desc "Decimal PHP extension"
  homepage "https://github.com/php-decimal/ext-decimal"
  url "https://pecl.php.net/get/decimal-2.0.1.tgz"
  sha256 "026e30f71016d25f267f9b38ab80a94bed4779e05e9ff5f48d9b08bf1c18d204"
  head "https://github.com/php-decimal/ext-decimal.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a16c32563a8d1cb0512bf452c95a97c10d84bb5a3fd239ab596e6d13c7a7da0c"
    sha256 cellar: :any,                 arm64_sequoia: "4a89c73222d608a0548a6a240c8c66c3d7b5dee4676c5326e553cd4699074224"
    sha256 cellar: :any,                 arm64_sonoma:  "1baa8ebded2422662dc2a043e4e5d0bb1e497bd51ceb14a5865242bfc7612a0a"
    sha256 cellar: :any,                 sonoma:        "c76f58b00303abfa7a4b126b3ab76b096cf74477abef3528c3a458c728a75d28"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bae130c73c77e9e2727a46a84e19b6735d941c71ee513b2d66d17821d37c2759"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e706e91e3c10cf8d4fe310face5b61d99ad14e10ab7fd8d0c49b2ac496b4d3ed"
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
