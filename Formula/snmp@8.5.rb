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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "87cbe9bb6c71c51e0eaf08fb4dfa7ce8181c6950708e4c2572b658a591c0c64f"
    sha256 cellar: :any,                 arm64_sonoma:  "68b4490ff982a54db3e4b2ce1e13b558c1068c23ffde70023f5529a904e3e781"
    sha256 cellar: :any,                 arm64_ventura: "8f6979434fbfa53c61c4b01467e9f2944b39ebe9c997d864b28e2407ba8419dc"
    sha256 cellar: :any,                 ventura:       "e42fd47424b42e0f56cd0dfe93ecda011da708f34cfc801f07ce4cb21da5dc90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b11b18f5a605b2f6200ba90731da3f5eb0621d4629be02de336dec6ab8648562"
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
