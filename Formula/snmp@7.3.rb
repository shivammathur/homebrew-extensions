# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/17961920bc943802ee35637d0ed2269df3acb313.tar.gz"
  version "7.3.33"
  sha256 "348e8c7a07899abcb9e31aeebf082ce9c47178ad274879abbd88e632830d1d16"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "f57546c7e9e525bbec6f86eadd2b572170fd0a173cee9ae78783f7e8d59f2d7f"
    sha256 cellar: :any,                 arm64_sequoia: "af601760edccc3c529add2d23d337e703780651aed834448f55946cf569d0345"
    sha256 cellar: :any,                 arm64_sonoma:  "e387581eb54cf5d12d43f780ac084ab7c52e2d4f665c0bbb232f6217a7c38e42"
    sha256 cellar: :any,                 sonoma:        "2ee02c747686729947d886be9d631dfad8334cd269f4316e274f9e44a8361c9d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3833c176f3d060ae768ab07eb974e3251f699271fd4ba36cd221473a2b6b9b6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86f4b860d585a959040577a4fafdb37512bebf356d47c57de1336648d0bde8f2"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
