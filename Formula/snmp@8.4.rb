# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/0b7a0e9f414cf40183a7ab53dacb8979e192350c.tar.gz?commit=0b7a0e9f414cf40183a7ab53dacb8979e192350c"
  version "8.4.0"
  sha256 "3baa53f8cece6cdce5b71b6d0c6427da8fcd5e6ae4729bc5ca60333e506f1fe6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any,                 arm64_ventura:  "8448b850c610cc8ef9b24797e7381dac257ea00fed7eb85262305fe989c639e0"
    sha256 cellar: :any,                 arm64_monterey: "491c69b1498b47c375ac0a1091a3eb5c9e13ad4701f097febc667106d089c080"
    sha256 cellar: :any,                 ventura:        "b8e5747b71bd6ab0ea91eb3ab21786af03e03c301f2dcf99bb489d0337108dbd"
    sha256 cellar: :any,                 monterey:       "91d0b5897ebab7fc0d9ec98289037987b1b2db7ed0942ddffe95615b3deaa0c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d70252597ef49081efae3253590c9168286fefe2e70efeeb4f849b5353529840"
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
