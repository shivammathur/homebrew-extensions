# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/78eed5e70e3c16e2d310ccd95b9e247891033cf5.tar.gz"
  version "7.4.33"
  sha256 "2514d5ba7da9f9546a3be16c88f11ab59fa89796a3cf2b6b3f747c596c7c8b21"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "7cd8c13c086719091ecada1e99aaca2d77a9c15abac38b517dd383bc6a5da499"
    sha256 cellar: :any,                 arm64_sonoma:  "09fbb060ffce910b460e45af8871857b3d531f2aebef138641f7dc9e64b3e9d7"
    sha256 cellar: :any,                 arm64_ventura: "92c926d8c2131b92d8142b98e15d3859372e4b2deb69a230ba6f27826e89680a"
    sha256 cellar: :any,                 ventura:       "54ff58818f8440c33155fb00425ad0fa9179d653204cd6580a95624908619d09"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "99f8ba49cd0fa74104a3d60ca3a11550e6dc72511f22500ab7bf939910bec38b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f11f648a005ca781487b877804876b9f3b8bbe91e4429756866802bdc38a0b9"
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
