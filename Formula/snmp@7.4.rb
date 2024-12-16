# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9d5dc7ec3c99d9463d9086d37bdfa00f4978595c.tar.gz"
  version "7.4.33"
  sha256 "8bc8e205e3016421c51562919ae0f52bd275a9d9e8d1d135b5b2418f05958f24"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "6a54bea1789f3c7c6c5352eb67d9ecce557d853814cd6b54a698e24a93c2eff2"
    sha256 cellar: :any,                 arm64_sonoma:  "4c4df6a0ace94d49f571a95a1fdb73f914e51e6a4efc0651448def93cd3d46f2"
    sha256 cellar: :any,                 arm64_ventura: "ac59394e0fb3a5ae4ced316e7cdb1a3a121d48dfc4ad85151c6ea90a304c0ae1"
    sha256 cellar: :any,                 ventura:       "ef45b34801d5d521f8ccd478b955d424b414d5617aeaa03153d8530f100929e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c5b57f71a2caeb4714c797b7b14548273d674e3afc6c8b1c769758e646e52a2b"
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
