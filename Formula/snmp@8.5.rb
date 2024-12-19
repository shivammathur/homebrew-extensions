# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8aac6987c21bec6e0744cc52a1e8d0366713c880.tar.gz?commit=8aac6987c21bec6e0744cc52a1e8d0366713c880"
  version "8.5.0"
  sha256 "ff98cb8c80376e2e98e343a77b90e5f33d923f82995b3348f45ca497af551087"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia: "13f7d33726efa35b5bfb2cabf188bc7fc14a7cd077dcb0a686aea7066eb12d4a"
    sha256 cellar: :any,                 arm64_sonoma:  "0dc33872431f5423635c708b63efc7cbeddf664996326ac0097f650715326c20"
    sha256 cellar: :any,                 arm64_ventura: "e7615b9c5299bb6d3e0802e190a71c04e816f5eeda66af1265c9ae32675613e4"
    sha256 cellar: :any,                 ventura:       "04ba1ce881d5eea7f3a167a6e42b1e03af70e7def7bc040741cb27066125e37f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "19fa4c39c3d37d960791b332dfba35d402864df29296ac0ce57c24663d58d380"
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
