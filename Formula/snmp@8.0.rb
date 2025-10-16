# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c56202b2b1f37a474c0f779253487420311f2f42.tar.gz"
  sha256 "091e70a151ec18206aa15a69d774ea661b0d43d4ba3fbbb3f794a5e81773ffce"
  version "8.0.30"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_tahoe:   "90a32990bc8c1585781d7efcd78c198fb2cd52bc24256fd96515c5cd0fa41925"
    sha256 cellar: :any,                 arm64_sequoia: "766e13d7d57660a8595e7a2968bdf27fc302aa2a61029556d05f0bcf76e02d43"
    sha256 cellar: :any,                 arm64_sonoma:  "b271b239d6f306c7ccb962b606d2b7c82b1fea2f339261e0296cc7649c1ea4bc"
    sha256 cellar: :any,                 sonoma:        "74124798a90f8ce7113dce50ee53de1836b05ca6f7f1a8b5b1fbd276e09b3177"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "659c15837327a6085bd9810e2edeb013a76735d3da5fe9646a4fd1475f75777e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "936d6a0931119935d36d5297ef83bda7d1eff2cd5b9fbdb3db436fe94fe611bd"
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
