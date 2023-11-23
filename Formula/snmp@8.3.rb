# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f35a22adba8a7ddf709c6cc98ecb57ba4dd8fe8c.tar.gz?commit=f35a22adba8a7ddf709c6cc98ecb57ba4dd8fe8c"
  version "8.3.0"
  sha256 "606158dcf15936552e4660795aa0f4258a3eb0814f2b42b6ec667db0dbe8686f"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any,                 arm64_sonoma:   "ded3e04c8d7576ebfc85578a12ebd8faf21c833111913108ef141bfa0a98aab5"
    sha256 cellar: :any,                 arm64_ventura:  "d43f266a3e2049bdd921bb8e5d6f99c4600a719eaee2951672a779a106e6b63f"
    sha256 cellar: :any,                 arm64_monterey: "54648d02d17d6e27547bb09eddc6ea6d75277415ae2f36276996cb7f4df29c0f"
    sha256 cellar: :any,                 ventura:        "9657cbd07c025de86c4b09743ee5aeb6b89bf71152bd487e29cfc108364afa40"
    sha256 cellar: :any,                 monterey:       "d470b77ca39f52e3763654a2df3bf4fdd9ac6973ee51bdbbf583af399f32a7e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57dbd3c59cfc80a705bdde0bdb96f681f106de73523b2dd372cf3c591eda2cb6"
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
