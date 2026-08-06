# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5a576d8eb53e44aff3af9259cfd29e599f604471.tar.gz"
  version "7.4.33"
  sha256 "d82887f2166e8526ea9b1cfd8c5ecf5649718f0b6e341380d333eba8066429a4"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_tahoe:   "381a37345839645593308e0a857e0ca417187c2b483f03188b079396bdebf051"
    sha256 cellar: :any, arm64_sequoia: "c1a6dce768327ee82529c161140832b45860e9a30b63aa27f020a3cd814f4383"
    sha256 cellar: :any, arm64_sonoma:  "17b4374f4e81260d6c13d594b86715b087a182e61952de2a017741560fcc9c71"
    sha256 cellar: :any, sonoma:        "f9d8d8931d04ac68c9b9eaa4ea624dc58196f7b7e2d4019094d83ec66dee06d1"
    sha256 cellar: :any, arm64_linux:   "3a62fd0a7aea92d5c2b0e4d37fcb347bdd2de851d6af8c485bcf1ed8ea625d04"
    sha256 cellar: :any, x86_64_linux:  "70fdc8e740d3000f479b4e34506bd4e83c3a8b144fd0f72e27e87372bc28bfae"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
