# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/aee204b665de64862d7832726ffba80faf253746.tar.gz"
  version "7.2.34"
  sha256 "12bb8a43bf63952c05b2c4186f4534cccdb78a4f62f769789c776fdd6f506ef6"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "e6ff06488d196d26d059bda1f9d05c40c24c071886c8c2bd917b223e2dc806c1"
    sha256 cellar: :any,                 arm64_sonoma:  "d1fb6fdc0f0ca9f904fe241d73df36807d7d0c273117922121c7384e1a3adeeb"
    sha256 cellar: :any,                 arm64_ventura: "398840d51fbc8d65ec273afb639842fea85d1fbad9bbdbb2473dceacb0fad89c"
    sha256 cellar: :any,                 ventura:       "c54a014b841cc0626d2a7f6622006c22397d2f6d3743ae9cd43b4e96bbcaabf8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aac3f3a570162023fa8dd28b89ecc3dedcd7d5050c9af2a2b7226f2f151c8ada"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
