# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c796ce5713f21a3de77e710f4028c62f45bc0fff.tar.gz?commit=c796ce5713f21a3de77e710f4028c62f45bc0fff"
  version "8.3.0"
  sha256 "a18ab59f65fe42870f2085fb9ef293bf03a39e7f7021c08f710503e287bbd885"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_monterey: "e067a6a4fd5cd62f037b27a443eaaba67f2dd0ed96cb6aa5161c4dcd8305e68a"
    sha256 cellar: :any,                 arm64_big_sur:  "fe029b94b537c2b45017e95afbbf891ddd37d1867ddbbc8fc3dc107ec28505ac"
    sha256 cellar: :any,                 monterey:       "bc4668d70ddf73e8c4ff1129a56e4b78748f327d8157c7cc5fcb8c54761107e7"
    sha256 cellar: :any,                 big_sur:        "a56bb7db50d788788a0b21b7e770072bbb27008e933c7cb0b79ae2a28b68ceb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8be2e3c895a7a293c53ffa2efc28993637f422a06c310983e579b531e4b23f12"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
