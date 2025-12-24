# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/383aaa666ea5d825183dde9e676690f62f21ad88.tar.gz"
  version "7.2.34"
  sha256 "3b48ab3d2f57cc29e793846446024f7e1219641647bf1d678a5effe460358d4d"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "193164ab022d4228f8730c6cef18c077456d8b78b21acef731f1edfd0e0910ed"
    sha256 cellar: :any,                 arm64_sequoia: "e743e1ddb0c4fc2c07ffecabc8b029b160a8f1413c074e2f7dcbc447fc15c07f"
    sha256 cellar: :any,                 arm64_sonoma:  "afb5c3af4f04989cdaac899e00271db1d9edbea670a8d02f00f39d7118be5812"
    sha256 cellar: :any,                 sonoma:        "08d3b2c2d396d2a963a9289ef817c407b9b7baa7fdc2c8c28d80faaec8812266"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "26f965dc57158f980d2f8ff3ac82a40a8a3293991f327ad7ba449f249dd85033"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "05a6c919aeda30bf23660469f5a9f36ac252b7b7a73a8e04e940b4cfc9ca9de6"
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
