# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2013f21a26a5d3d3adefc2a6f903ff28ad2334e6.tar.gz"
  version "7.3.33"
  sha256 "69bf22cebb9cb2c381ca68be7088fdff5751c37d667286f9f11ff984e8fe5889"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "34398cecd7a690165e9365eca24a660622c252dc38f080412e9787336d1e9c75"
    sha256 cellar: :any, arm64_golden_gate: "b0485da4a158dc95127f72a5bf6c5d4e84fb47bb7466af28127c416ed3619eab"
    sha256 cellar: :any, arm64_tahoe:       "ebe3c04c542e7122d306be57a6e82024fb1ba00beb4d705f3b30149e6bd1132b"
    sha256 cellar: :any, arm64_sequoia:     "158654fa92e82bc58c1a2f4f06c6e18090f9eb72153ce240b2ddd8536896b2e3"
    sha256 cellar: :any, arm64_linux:       "5d2472cf00e9b0bafbbbc208f008243c8dd2efdeacfd5842478064a06a471930"
    sha256 cellar: :any, x86_64_linux:      "181ad110d73db2db4c397950210225db89d98042ddcf447e97accaee5b694282"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
