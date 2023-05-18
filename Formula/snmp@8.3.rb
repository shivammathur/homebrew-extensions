# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/bd03c0343e7df2e70fedf872eea6eb855f3b76e4.tar.gz?commit=bd03c0343e7df2e70fedf872eea6eb855f3b76e4"
  version "8.3.0"
  sha256 "705000a8f0458154117599d6f769a70045dc028693b2b7f543d06490bde4f4b5"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_monterey: "7a44d7aa75288c6c95eb25e9bb9c223e460b937e13f2d2029558ee6c26a87a41"
    sha256 cellar: :any,                 arm64_big_sur:  "337cd6ea39d5a058cfbc71cdb1236a8c4ee0adeb1f7bf3349ee8aae167497435"
    sha256 cellar: :any,                 ventura:        "266a26cf16017aeec10da1bda22efeb9a289ac45d5896ba39515916dc4cfe2c4"
    sha256 cellar: :any,                 monterey:       "649d3717559d2ef353a09fc177fd178d6c5c437020038fdcdf8cb0442ec0b514"
    sha256 cellar: :any,                 big_sur:        "ac9141770aa914654b339aa7b835d3a46535aab7f425ad0ce9cd8f3c79ca2542"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6e2763b2a0e11eb55639b75987691cd4c94a53b4d3c788ed1b67af0d799eca4"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
