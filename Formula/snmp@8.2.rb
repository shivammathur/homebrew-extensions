# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.28.tar.xz"
  sha256 "af8c9153153a7f489153b7a74f2f29a5ee36f5cb2c6c6929c98411a577e89c91"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4e8b945fac6f9177259d34d8e366ec6e9e610de927c6bd4ead07f9bd48cf2f6c"
    sha256 cellar: :any,                 arm64_sonoma:  "d5a3d6df11d91bfa35d80f60ea1c83873d8cf1293df91460e8f1a0cd90031d58"
    sha256 cellar: :any,                 arm64_ventura: "173806f8e6ce24226d660db6720f60140ebe7846dfb432b0b286f6de1fd06adb"
    sha256 cellar: :any,                 ventura:       "af0d3c579ed2713914e5300f31f9c3bf252e5f96e55252f364f9a1e400530168"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "09261d850bb786a768a4d6bae143815bcf5bc1b403f702aae3426fb37704e5b9"
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
