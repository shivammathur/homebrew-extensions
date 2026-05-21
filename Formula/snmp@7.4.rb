# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/196d6a472da2fca7b2249335c60b6fd60bf3c98c.tar.gz"
  version "7.4.33"
  sha256 "30f4aa482e34bb2631a66450943256b220e8c13908940bd5c5d78fe743b3e5bd"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "7cdf76c5cbcb419ad9c15ebef4d949240d0b244de26252cf0c24a91ee16d826f"
    sha256 cellar: :any,                 arm64_sequoia: "8d3cd8235b0f3aab92cdf1fc124a5bb372febd5c9adf1c203aeb82a692978cd5"
    sha256 cellar: :any,                 arm64_sonoma:  "b4d34af875930bd9cdeb66948160f87a12c79ac13ff2d0555f0bcefbf78f724c"
    sha256 cellar: :any,                 sonoma:        "ce6f79518b239cbeaf61cd33d3874026a98fbacfa73c1b4550f788445c27ad3e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6a49ca0d39ba4246646d0c1010d45bde01e89cb9acaeb3989f4d44f3c459b23e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "36c932445eef8defe515cf00161c936d2e8b24a496ed8dddcff54e769f87a0c7"
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
