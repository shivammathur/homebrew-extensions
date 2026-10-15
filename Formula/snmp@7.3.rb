# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580ee90c4416b2dabd488c58fc10f23c1559cd57.tar.gz"
  version "7.3.33"
  sha256 "1ec8487f024bb3bb9ab18a09c72b4e6cbe71bad362f4188b191f5bb6e59ad371"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "8d575dfc126ed63715ab67fdf473e867b91d3592d8e6e32af32cda838f147597"
    sha256 cellar: :any, arm64_tahoe:       "d348ac3681c694a5f4db171ae5cac5112eb4dfed89a73c4efb57e6c54c4af4e8"
    sha256 cellar: :any, arm64_sequoia:     "e80820818a0e5036c13a8af2bdde7dac57eb61da5d0bcb16d3b6dee6e8bd83be"
    sha256 cellar: :any, arm64_linux:       "ad8257dc093ef9392491b5eb54564c076493e806a5ce1eabae30ac00f72bd773"
    sha256 cellar: :any, x86_64_linux:      "789fe337e2817d090dd35ef1f24a2fdb12cfe20627725b92e253447eff077714"
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
