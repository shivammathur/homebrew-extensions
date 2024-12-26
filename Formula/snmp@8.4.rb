# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.2.tar.xz"
  version "8.4.0"
  sha256 "92636453210f7f2174d6ee6df17a5811368f556a6c2c2cbcf019321e36456e01"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 63
    sha256 cellar: :any,                 arm64_sequoia: "48ec81fa32ae19893ce37ceeab8a08cd176bcc9a0b55c7a3ccd903792699b8bd"
    sha256 cellar: :any,                 arm64_sonoma:  "c9fd210f01a34ae07723635ee3ca5ec455a66a79ff25ce50fa4a4378ce48c9dd"
    sha256 cellar: :any,                 arm64_ventura: "373887c34128b5067b146012dafe41217f81999145d2d630b9d0ef4229bff9f2"
    sha256 cellar: :any,                 ventura:       "f4db07dee35423f0c2222c90418466837e4980b4639810118616ea1145cb4dbe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "72991f501e4eb7152a1736a1a0b4bd13d966e938b9c666a3ef09c99c058621ee"
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
