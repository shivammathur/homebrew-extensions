# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/421d8fd17a77fbb7c6c9dd4effeccd904025872d.tar.gz"
  version "7.0.33"
  sha256 "7d75d172343920cbd1ae1a8f02556b290180db94eb0fc308c09a2c926ef601bf"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "c4709e23dde901962403a8dafbba59e78041aa49a8d2c688648c6ac0bef96b33"
    sha256 cellar: :any, arm64_tahoe:       "761f2c3236d9d6042d285e0c9252905c649d7fa895b9e1366b0048f2ea9a417a"
    sha256 cellar: :any, arm64_sequoia:     "e27de10eeb5cd70aa4ac0dde5979dfd60909537a4fecf2cbaf539655feebe62b"
    sha256 cellar: :any, arm64_linux:       "0bf0159f6ffa014b3cd1f60e21a73e9577b601424498558b3b076be90d1237b4"
    sha256 cellar: :any, x86_64_linux:      "7a420e73606080683c149dcf7c7e0ccaba369735f2dd4c24f527830547d415af"
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
