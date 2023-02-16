# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/8c84e4ab015127711d096c461c3ec661dcd8c925.tar.gz"
  version "7.1.33"
  sha256 "4aa6a4d33f4a67fb92f64f7b264b84cd3b81993443bce3b358e1b15acd7e67e4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "d7257d9370b35400ab21fe8444ec9884fa17478f2c1b5354fe8a715b592a8a19"
    sha256 cellar: :any,                 arm64_big_sur:  "9ff7a59cbd9360ee9d86cdd66435af976f6230a94ffd6b2f436c270d451ed2d8"
    sha256 cellar: :any,                 monterey:       "8884e85a2b885a764255ddaeebd301ccb1584930a68d0ee05185b740b02fc4f9"
    sha256 cellar: :any,                 big_sur:        "6dfb20efb3cf8c83115fa20f1b7a2ee76e1a0c125eb15fe316855721c09584ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c482993f9f8d553c8c1810e4396766df71ddba21a98ee66deb84e39807e9b257"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
