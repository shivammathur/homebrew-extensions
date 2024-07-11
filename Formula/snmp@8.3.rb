# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.9.tar.xz"
  sha256 "bf4d7b8ea60a356064f88485278bd6f941a230ec16f0fc401574ce1445ad6c77"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6ff8b7a4cad636dda4fa65abdf00b15797057607046f303b0decae1e87c9749c"
    sha256 cellar: :any,                 arm64_ventura:  "174734a2a58c963cb791750ee0fc99c77f8f2364c2e43cbafa86c00b1c311feb"
    sha256 cellar: :any,                 arm64_monterey: "b1cc4d2c2a7c3fceda3d1046276ae23e2b77d2ddef195e1e525bc7c5b68919cd"
    sha256 cellar: :any,                 ventura:        "9926316d97282975d42d4194a853cfc61151a7038a06e9b9cad8c8aa0bd00350"
    sha256 cellar: :any,                 monterey:       "e209c482dbc775470439e21dd3da4ddff04d2f740bd288e6ee6480af5c349093"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d899fc5346e032eb861088573cb8e888089321b3a0f1d691c45bfd74da1ea09"
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
