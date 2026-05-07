# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.31.tar.xz"
  sha256 "66410cee07f4b2baeb0843140bb2a2b52ef930b5cf9b3d6e6d158b33aae8fa37"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "6a4a2d9b5ca2eef6b2610bf3f0c6c2899b59898405324787ea1de03fd52baafc"
    sha256 cellar: :any,                 arm64_sequoia: "7c5a344bc7a27839ddf3453d99fd1b610e76e0e2dd940235dd2eb8dce30cacc3"
    sha256 cellar: :any,                 arm64_sonoma:  "0f5cd7824c355700939b263e8d50380793c0615563591cac0b858dc52698924e"
    sha256 cellar: :any,                 sonoma:        "0a48274c3911fefe714deb8086a7b7cd81316f455ee9867d36fc5628ff24c243"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2b3c29f8356942a820daad667726085a575dd41a776469a1bc2245f819c4d8d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d3cecbb00bc3c1197b0b122c097d7ffdbe0bd359e98ca8382c1912b9160b2f33"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
