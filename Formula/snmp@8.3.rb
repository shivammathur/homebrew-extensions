# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.11.tar.xz"
  sha256 "b862b098a08ab9bf4b36ed12c7d0d9f65353656b36fb0e3c5344093aceb35802"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "f0a465d4e7feb5f64fbfcbbd6e2440b14a5562ec445dbb163d87f04ba09bbf13"
    sha256 cellar: :any,                 arm64_ventura:  "ca1f8619633cc85ed130080f6cfdfc64683f4d338f7ef08065afed4641ba82c9"
    sha256 cellar: :any,                 arm64_monterey: "0a4fcf1369feae91121eab22a4a385da72967e0c4bea80953b5a46700a8ce769"
    sha256 cellar: :any,                 ventura:        "41c93f7f01e7bc969082f801987de0bf0e76a34ce930465e228a33195259cee1"
    sha256 cellar: :any,                 monterey:       "547760935fdd3f53c94e6aab74301c62070f0bfa885167acf3f4deb93242bfe2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c1cc819970771af574b1e79ff422bd1b0849549a34ca111352c5545560bb5b5c"
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
