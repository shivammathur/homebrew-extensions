# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.28.tar.xz"
  sha256 "95d0b2e9466108fd750dab5c30a09e5c67f5ad2cb3b1ffb3625a038a755ad080"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "cf7ea55a06e2a963398773cb5f8e80784659c1eea72c8d0897265cb9d3ae68b5"
    sha256 cellar: :any,                 arm64_ventura:  "b64782d48562b3bca526e1c9bc42293ee11b8a8eda690f2a7ec3e4475783f6ec"
    sha256 cellar: :any,                 arm64_monterey: "56ddcce7be7cee392108ab7dcc31d189dbb7a202c882cba88d150d0b3a992e1b"
    sha256 cellar: :any,                 ventura:        "f9f8a5589cff925da45035b600c641598bffaf3f208ee2179ca6116aee5ea825"
    sha256 cellar: :any,                 monterey:       "29a11dd4c259128066414b9314d5dd654af629d965e67b3ea64cdb34c3c99a93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b697b90a0d9329eb03f515a64313a253fc5dfb70fabf32765670ea941d8d1669"
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
