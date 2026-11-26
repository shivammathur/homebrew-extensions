# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/421d8fd17a77fbb7c6c9dd4effeccd904025872d.tar.gz"
  version "7.0.33"
  sha256 "7d75d172343920cbd1ae1a8f02556b290180db94eb0fc308c09a2c926ef601bf"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "21eead1955ae0164bf21b02f18edf1720b6e373b5fdaab1ff415a01d30c5ec43"
    sha256 cellar: :any, arm64_golden_gate: "d051fdb6f8c741e3f0afe49e33f73f476b6204243286f7cda783abea5f1d1ccf"
    sha256 cellar: :any, arm64_tahoe:       "7de986e9843d549b78f2b70fe8fb48e35e43d8a5152d0a3a1d0d8ef2ce9155e0"
    sha256 cellar: :any, arm64_sequoia:     "0cf18115ae5d63141d9270cb2cfbe718133226bdd33f6df4e645c0a7a7b410f5"
    sha256 cellar: :any, arm64_linux:       "f67f276ecd9c9423d79fc65dcb563be7963bf80acd78ca2f190126592f5e4383"
    sha256 cellar: :any, x86_64_linux:      "32ba79a4b977c376352e1c87c98e7718f1dff6d833a0ef54670a3365a32b897a"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
