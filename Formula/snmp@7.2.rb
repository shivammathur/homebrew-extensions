# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/269a597ce7d22198bca3745157a45783d86da7ac.tar.gz"
  version "7.2.34"
  sha256 "01e8a6bf83a7b5e77ec6b02d5933e12a39911a4f34bfa572d99ac0020c9513b0"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "4a96d659e1fd5e9272c3b0e7a61dc8c14a9220c32a33b2f63d907239ad96e1a6"
    sha256 cellar: :any,                 arm64_sonoma:  "e2fdc6447ab2cd1705b63f63ae25768cebc58ed25b6fa98a337785e100fe7aa1"
    sha256 cellar: :any,                 arm64_ventura: "dea2a5c33006d4f38ea2e73384f687884738d99af8321b081112f68288fa05f4"
    sha256 cellar: :any,                 ventura:       "971fb74efe7664733cfd245d2b079d11ce9adfab68837475fcc6b763c23f35d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4dff5fd9ec5d2d9b54b30689dc8171db6d9b0038c70a08218172549bbec4a22a"
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
