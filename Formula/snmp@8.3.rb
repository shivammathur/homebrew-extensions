# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.10.tar.xz"
  sha256 "a0f2179d00931fe7631a12cbc3428f898ca3d99fe564260c115af381d2a1978d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "11a0218ec68e39df4568395f8aefe2fac84d3c90f86be8cc388c97db7abac2a2"
    sha256 cellar: :any,                 arm64_ventura:  "8d67876cc42f8e8d23e8ab888fbe079e3d575153a1a84ba48e0db0fd241e50b6"
    sha256 cellar: :any,                 arm64_monterey: "f1f0a276c68037c753603f180dde32f13ce8883266a568a48ebb5d892c31e5c9"
    sha256 cellar: :any,                 ventura:        "a061b8c6cdc49d6e20e74e720dc1f8590dcf4d72ad2f5d1fb6e209843d66945c"
    sha256 cellar: :any,                 monterey:       "e85cec6f49de52cf3aaa7478ad23507ea588c9bba352ead53330010f57413f96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cdbed753ace1fdbe3fba57045c97a28b1ba11ca98c6d812aa926c1f7f155ab29"
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
