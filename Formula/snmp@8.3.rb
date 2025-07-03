# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.23.tar.xz"
  sha256 "08be64700f703bca6ff1284bf1fdaffa37ae1b9734b6559f8350248e8960a6db"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "398175f9329beefe256c9604388beb2ce8033accee6718e7c588197af18d1900"
    sha256 cellar: :any,                 arm64_sonoma:  "9c562f130022b5d627fcacbedb303a1628fe82001cb630733514516486fb7a27"
    sha256 cellar: :any,                 arm64_ventura: "4d1f4c2dabcb0afe81f4143b3b9fbc195408f9e7eef2b1eef01d9259042ad9d3"
    sha256 cellar: :any,                 ventura:       "5c93d2c2db6b32fa53d65f422965f97352f63495254973dec3cf9266cfc6508c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "04d42f65d09ba757f6da0154401f0953a46edee8eb3c721180df827c6909c266"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb325714b23b69c53b38a1a1ff60c1878d333b7a67b538a0dc03179d8d84418f"
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
