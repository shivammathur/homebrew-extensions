# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.30.tar.xz"
  sha256 "bc90523e17af4db46157e75d0c9ef0b9d0030b0514e62c26ba7b513b8c4eb015"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "19dc18123968ba5df82928e3ec79ab81b0488f78d646dca6bd05814c363a74f7"
    sha256 cellar: :any,                 arm64_sequoia: "4a0522c46d078c6c983b2dfbad6e5dbd0033efafa247a730df8eb566ddd8fc8f"
    sha256 cellar: :any,                 arm64_sonoma:  "0c672bdfb766a8f3c9ebd6d547735216cb42db35ffc3a310bed10e2ac9cf8daf"
    sha256 cellar: :any,                 sonoma:        "ec352356858414bce81938f3654187649a948fc8065ec007862a42a303d387d9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8f0115524ce41153d0ac712f182a15ce0b33cf62acd7f226d5d900effc69f114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5995f70f259eff09a00bbe2824d2d7130e4cffc86772eff7536b2c9c08c68dcd"
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
