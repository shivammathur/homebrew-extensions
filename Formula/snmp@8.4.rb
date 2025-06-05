# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.8.tar.xz"
  sha256 "aa6a4d330b47eacd83e351658ba8c47747a1e4356456219cfb6d75e7838da091"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6c3bf4e3232dd7c91bc0a4124f142adef32ffadbb97ab06c6cf8734c14e72a54"
    sha256 cellar: :any,                 arm64_sonoma:  "ed5321373fcd55cfb9a895771eaf38c9a3748d02a9665b3bd212ace5b602c32f"
    sha256 cellar: :any,                 arm64_ventura: "68dad5a7b8ff8d5d6d680908ec322d039c19aad93dfce25b7415eeec8bba4e91"
    sha256 cellar: :any,                 ventura:       "695b2b4e722fb86b22a71ff5780673f68fd5b69fb1d813c28952563827b14258"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "eac2048619a79d1e0d66ee9062d3400e2215addb89baa2238267b06416780f0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ced169ee56d525983164926746756c16473317207cca34aec8b5bde1b845d534"
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
