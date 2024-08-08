# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0788496bca56ea3a6ad75758aeaa38f81267415a.tar.gz"
  version "7.0.33"
  sha256 "6b59873eef34f7205e20683a0e6ad99509a1c158e619ff52ae6269d64d49f5e9"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "666566782c5482dbdbef592fc4550a8eb407e14e33b4fe1264d92bb4e5b64931"
    sha256 cellar: :any,                 arm64_ventura:  "9fc5264450144b404ee53711de47c5ca32e00c15fc1977fb1415e1c5fc7f89d9"
    sha256 cellar: :any,                 arm64_monterey: "22b9e4c6ff0649c960b77737914c9a48488d3be67e7713ff8a6c7b43119b20dd"
    sha256 cellar: :any,                 ventura:        "ec9f45b0388d9c205c6b45b885d64b0fc63c5419ec35f3e7f375b777155ac20c"
    sha256 cellar: :any,                 monterey:       "940e11ddfc17f5031aeea0acd34a3b3916f4fc5553eb2aa8f0e23a783e2cf85e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "22d4b822b3b106c503a2f267d04127dce9ccff5cabcb7b84e5213b107094d7ba"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
