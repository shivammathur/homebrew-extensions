# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT56 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    manifest_sha256 "7c078e2fcb7d1f14966625039274cbbc2b2a1dd34b0cbd7fe6626eb5ecd182e3"
    sha256 cellar: :any, arm64_golden_gate: "546aa86f77dc608e88d1b3081617b4783267eecfbc162ec62dd8a5a4f4f031aa"
    sha256 cellar: :any, arm64_tahoe:       "fe648d5320fb89f8dcac2a004d2209680f52bd336c48ca472048536ddbf0cf62"
    sha256 cellar: :any, arm64_sequoia:     "6984fafc7bfd1aab096034f95c5961007b106060593db3b6227cdc992429418c"
    sha256 cellar: :any, arm64_linux:       "4942ba87041ac35a921a1a3d96dcdd9632d4dbb2f06435c79c076d517ddf5c54"
    sha256 cellar: :any, x86_64_linux:      "e074b01afef2b55fdba280bd0fb72656b6f8e9dc995966555789c943e5a4e3cb"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
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
