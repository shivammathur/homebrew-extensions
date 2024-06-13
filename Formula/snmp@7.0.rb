# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a4ea0fdb28141b4ca8c902d7dfceea9b435fae33.tar.gz"
  version "7.0.33"
  sha256 "59e7a3a8c00e063fbc4c1698824751b5ccf6e9432522347073cd8edb0c9ec98e"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "18523ce0f8edf9e713c0542beb918b5619601a3024769e6273966c9f0e0134f2"
    sha256 cellar: :any,                 arm64_ventura:  "8a58845d2ce497c770d67f590ceeffe344ac06883345473c964736b73e352c5b"
    sha256 cellar: :any,                 arm64_monterey: "afe090d00423e0657a95b6f692d2e6578fd02bb890bbb26d0ffdcf3e23ac1a0c"
    sha256 cellar: :any,                 ventura:        "66ab7e324858df5285bacad06ee747bc18fb482e357ae8718caa085bb49afe35"
    sha256 cellar: :any,                 monterey:       "15e659728460e96b7c332ec84b534da560fe78705c0cbfbd4bb44c149cc5761a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe3136e50a86c38c025255115065b7fc2f50a8a80a748a18ea28c98a8913ddca"
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
