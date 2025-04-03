# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d91f3b4e4ff74ed2432010dca9ae9ce5de781670.tar.gz"
  version "7.0.33"
  sha256 "2d80d4186c14aa7e75cca38105359eda808a512a57824462e84e96d5b1be6b5c"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "20e503a79f617609f8166f07d61bccd86170f0c7abb5f4edac5bca2d4ebcc912"
    sha256 cellar: :any,                 arm64_sonoma:  "2cc5a822b0d408a79fdd6e352195055d1397c368b031eea7c34440f8eb493ac5"
    sha256 cellar: :any,                 arm64_ventura: "c27cae202ed78985e3bce2c8b2add17a53166d7dd984c00facfd57f4eecb840f"
    sha256 cellar: :any,                 ventura:       "548bc11231acfbfb48898cbd17f3b5b0629dedc0ce3817480cffd9169edacd90"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "27b4510fee431f8f53d73ffaf26041615967b8bb43346910b97649602ef43814"
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
