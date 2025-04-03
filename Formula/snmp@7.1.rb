# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dc8d6277d12d445642139b8a7c104898a5a80f80.tar.gz"
  version "7.1.33"
  sha256 "3e7a3342f58ca8698635631993a91541d88e7ddf3335e15194d23dafd5bae409"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "5782744bf29c1125790fb05c0a7ae665ad8fe273720816d3828ec877b42db8f8"
    sha256 cellar: :any,                 arm64_sonoma:  "8f28068bd76079eb740d6ac39a59f87d60ddfe05296c8ed19363b2400ec7eb09"
    sha256 cellar: :any,                 arm64_ventura: "4830e1fc857c333e9cbc2b0701919a5859eb19d91c367acd8730685aea7187fe"
    sha256 cellar: :any,                 ventura:       "928b4a4030ab2cae22e7ef3d28819d581cfb19ddd7f07bda2a6cdad3b2bd5845"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e454b6785fb5983385be0f8b1561fef7142a95ef007e22b46e05d25ab70a9b83"
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
