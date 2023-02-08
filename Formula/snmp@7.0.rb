# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/541ed65f675463aea6c6eab55de38719b2d10625.tar.gz"
  version "7.0.33"
  sha256 "44a0552346687dffdeabacd4f9e641eee84f2630e852ccfd44c49e0da2fa515e"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f2b05e32bfa40f7616aef18d69c796bef68af4ffa1b732dfe38674c512e6cc1c"
    sha256 cellar: :any,                 arm64_big_sur:  "5c47f26cf777ff0a63ebb70f08f1476c8f6ef81bfca4e07688899f2be05adcad"
    sha256 cellar: :any,                 monterey:       "301fe94a2bd2ac09bdf5bab9e4f7cd196034f16737a8c5dc1228a04c3a281861"
    sha256 cellar: :any,                 big_sur:        "281aa3f25224a39bf16d482f051adcc62c1b2163916da3694a8d2a01d6790231"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "284ad5c070fe00c25c0cd36a43be7cd56294c928c6989acd1cb08659c1ad3cf6"
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
