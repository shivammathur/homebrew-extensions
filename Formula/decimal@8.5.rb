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
    sha256 cellar: :any,                 arm64_tahoe:   "ba7d710228b264d4461d09a94f02cc7088c6d96dc37f52a50cf19c0d923ee78b"
    sha256 cellar: :any,                 arm64_sequoia: "aa951c638a0ff887c5b02b8469b3c96ff4cb21dafc2ec21c7191f3d16e9f115b"
    sha256 cellar: :any,                 arm64_sonoma:  "ce2ade5bfe498f33f9361a35e21593303ce6c7b57d72cc997424b9becea0b3f5"
    sha256 cellar: :any,                 sonoma:        "bf3b2645107a7919cd5465ad180ab53252f9a127ce97ffb371b3924b61d04051"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d7a735b453af07fbb34586d77879d3566bcb9d1f302d8c39c6cd6a57ee407720"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37084a05073ac735781301a29d77471a9428d29c11bf7c6f6f82848228ae062c"
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
