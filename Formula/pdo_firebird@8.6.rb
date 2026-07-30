# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/90437857c10998aa1876308ad94dbca3b04ec170.tar.gz?commit=90437857c10998aa1876308ad94dbca3b04ec170"
  version "8.6.0"
  sha256 "0eeb248e2667614f7f920064b996fd7f5e04b9e12671da0af6084c32da0d8646"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any, arm64_tahoe:   "ff82fac73bf4208d59683e6b1dcb21888aecde377e2205c02b31e64f1a4da481"
    sha256 cellar: :any, arm64_sequoia: "4f38695c9516ecfece8897d933b343361d1d7c30e0d6de8190941500dc42794e"
    sha256 cellar: :any, arm64_sonoma:  "392efe6b20b612fed2adbe8c2520083c9124716b13f521e9d40540ccd1f944e9"
    sha256 cellar: :any, sonoma:        "d74bf59bb2f0cb78b6a5fa688c6a16ec408374f640b5bad8bdf945df52195aac"
    sha256 cellar: :any, arm64_linux:   "dba83e4db11f7714e6cd3bb981db47edc75ae65d87270e4019465bd8825981af"
    sha256 cellar: :any, x86_64_linux:  "60bd4a3c3cebd0a6865da112819e4b5209d94636b853225e3370a11d522581a0"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
