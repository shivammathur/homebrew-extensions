# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a39dc7ab765a65cc77b7a7ff2fe3dfe2cbba5c4f.tar.gz"
  version "7.0.33"
  sha256 "4f218a72364843aeceee8e7f170d20775ba2e9ae9fc0bb82a210e9bdd226705d"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "b73f7c5e88817f4f88cd4e35c6fc43b24fecf6ab0574a38bad097fb0948335d6"
    sha256 cellar: :any,                 arm64_sonoma:  "d1dd966c0bc12ae6171099468057931b37e68b807b6037e89d8d68bab4c68192"
    sha256 cellar: :any,                 arm64_ventura: "769779b926e052da07000df65889e095891254e8bb134b6f0b144e8bd3736ea1"
    sha256 cellar: :any,                 ventura:       "5b36b56b87567647e2aa8ecd40115a7c116a498a703cb28bc69e0042b2269920"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86cd8ef5c65f6b279a473275718190dbdbb6f7aceac32e07510b404ad4adde17"
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
