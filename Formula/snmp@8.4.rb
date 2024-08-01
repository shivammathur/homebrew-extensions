# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/28a7c6243c7bae49f6262b12425e8521abecec2a.tar.gz?commit=28a7c6243c7bae49f6262b12425e8521abecec2a"
  version "8.4.0"
  sha256 "d206820ef639abee34fb3359bbb3f8528fbb227f0cb31f6690f737c508b8cb4e"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 54
    sha256 cellar: :any,                 arm64_sonoma:   "110763da671b535348a81bda75af0d9b2b8ce7d2c53ad1d814fbeb47d3e35899"
    sha256 cellar: :any,                 arm64_ventura:  "0a5ed4dc076c6de1b41eed81e49b22e2ffba1f17d50913b377abae3eec4f7adc"
    sha256 cellar: :any,                 arm64_monterey: "18e7bd69c6c6a8f63ab58753c82d014364cb4a4e5fe03cabfbc6809f120fead8"
    sha256 cellar: :any,                 ventura:        "cd0714a750068a1a624985c75cefcf11960bbb02706432142d54169dc1b1b89e"
    sha256 cellar: :any,                 monterey:       "edfbffc664c2e618917ca07cf4ea0b187370312fbb388d9ecfcbb694b0371648"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c1c330fb6ab8b4830042a95a7e42bc9957f66f49aeb02d88e3d0668910dc52fe"
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
