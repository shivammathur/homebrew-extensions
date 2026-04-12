# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Decimal Extension
class DecimalAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "46c64ec4fd52c8c19dd0e5f7a80ce3f9211b25bfe27c29c98196d871ec62262b"
    sha256 cellar: :any,                 arm64_sequoia: "c45b18858e2d94668d4b64ad254e64c61b88ef598fa3b3f60865c23b41991276"
    sha256 cellar: :any,                 arm64_sonoma:  "9c5bacc01f07364cbcc4d61560873d252e527e47e3cbf5d5a987660e1be19969"
    sha256 cellar: :any,                 sonoma:        "2293a24113bea277850431a061d6627efde6b2e92ce008a0d46236e0e7a49985"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2a5dbe65f9665797b62ccfbb31a4fb459b0b054829f6f8298f2262c5896f326f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8535a9801eb32ba74917ea169671c884587dc6859192bb00945f60773828b0b3"
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
