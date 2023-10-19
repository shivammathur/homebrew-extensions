# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/a831cbcde44e1bd4fba9eca93945091f0610a891.tar.gz?commit=a831cbcde44e1bd4fba9eca93945091f0610a891"
  version "8.3.0"
  sha256 "fd7d20757616d467de842e7cf47726268e3c3a31073b09d861b5b67536a0ecb2"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sonoma:   "d794127775ae911febc3c32056d41d2e271ae6bd52fc0a398c47c5bb9b7e496e"
    sha256 cellar: :any,                 arm64_ventura:  "f9b34567d22af99cc1d1aedd845490e5ecf6a37eafdb605626bdfb03e6dcd901"
    sha256 cellar: :any,                 arm64_monterey: "ac91de27d23bb07ea939ccd42834aa9b5d3f53ddbd55781bd132d5466cda6e1e"
    sha256 cellar: :any,                 ventura:        "09769cdf34805edfad2fc4709a9026c5fc3e3de74edeafcab7bda11b908d346f"
    sha256 cellar: :any,                 monterey:       "4fea09cc8907d2e154b406404d5480a539788c71838463c067af2f8425a1f83f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "501585de40bfab61bff003f47cc3d038b6c737c0f8fdeb55b6410486d22847b5"
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
