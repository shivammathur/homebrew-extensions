# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/aab281546ce42f7cb1e8dfc60e231d15cc56c7f7.tar.gz?commit=aab281546ce42f7cb1e8dfc60e231d15cc56c7f7"
  version "8.5.0"
  sha256 "a7d52dbd4b8d4ddc10ff93060c942463125b75bf0e56ac14060dd57178491dc4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 31
    sha256 cellar: :any,                 arm64_sequoia: "ff5c4916a4f0da571ac709c654f198a0ff2b2fbb1f1e9f58bd6cb496ac2b8ef3"
    sha256 cellar: :any,                 arm64_sonoma:  "217c1109954f17c5a0206064998fffcbd84006af9fce5168a2de173c4d5b60b4"
    sha256 cellar: :any,                 arm64_ventura: "e279904fee98b5a8f5b702d5485bf9af939f6139dbeebd79149d57b9496bb2c3"
    sha256 cellar: :any,                 ventura:       "46bdbaf19f833f3ee0774bd5fb0200a007b2d2ca22931ec3aa184305f0537dac"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "342ecde39f72b07416715d784b76dec4537e6333f18114fe36d642a784972f32"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cee90ad566ee756c008cda9788e20e717baf15a898e417f23e922025e81b243e"
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
