# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2ca142ecd8e3af5a2ac09938546b57123d01297d.tar.gz?commit=2ca142ecd8e3af5a2ac09938546b57123d01297d"
  version "8.4.0"
  sha256 "1171610b5b4398a7a2cc5ef9da33d17a2c0dc1ddb542b981d443f37deb05786d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sonoma:   "228223c1ec3ca534840cb49bb8c05a7c46701f0fe0ab0b940b4513ff054e5911"
    sha256 cellar: :any,                 arm64_ventura:  "b0e8099398705ce92bc7a18ff3b08439c7a683d967ff0e61aa2bc0a01de60f60"
    sha256 cellar: :any,                 arm64_monterey: "708255924faa4d2f018f50ca962afd8a5c8c92f829bb5c1a8e2d620417db27fe"
    sha256 cellar: :any,                 ventura:        "23f4c52b1352c0e0b524db0d0de75a256f12feb77654081b73e3b837763e3606"
    sha256 cellar: :any,                 monterey:       "b89649a1c78756d8886a081c435610f12727eae0f76a695fa73d3830e641a21d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "279fb23849cd42c47d26333210a75c34ab783668e4d9100466dde2911b83702c"
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
