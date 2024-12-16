# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/a39dc7ab765a65cc77b7a7ff2fe3dfe2cbba5c4f.tar.gz"
  version "7.0.33"
  sha256 "4f218a72364843aeceee8e7f170d20775ba2e9ae9fc0bb82a210e9bdd226705d"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "c6dea92bc7b8144105bd3910c99e47131097a4d14d156516b3b7403649f98c8c"
    sha256 cellar: :any,                 arm64_sonoma:  "d7c1bf3ee91977e26c5af5636fb6e3b4779c47964eb32a1505f6fd9fc9db2ff7"
    sha256 cellar: :any,                 arm64_ventura: "3810bb5d7d82e872695f11ebce60734abe31c2152dd632048b48751096df6381"
    sha256 cellar: :any,                 ventura:       "6f232d933e5669f8d96dbd0d31561435dc208b7e0dfb5e9265f46b667be00991"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d1864d95f9402b8f5145338dffd887e12ee2b629e70a765823e3d41c87d88ffb"
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
