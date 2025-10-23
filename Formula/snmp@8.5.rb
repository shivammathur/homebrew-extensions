# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/d378dce3e9c7384e6c1d1492175ca02f16ed8409.tar.gz?commit=d378dce3e9c7384e6c1d1492175ca02f16ed8409"
  version "8.5.0"
  sha256 "47905fda9c6be05e9a3ff1969e998e940280fd4e655927dc35c255003e376c3c"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_tahoe:   "6546c5a1382b21d1c53d714d74ce5577828b02650c2e7e617dab8823217008f4"
    sha256 cellar: :any,                 arm64_sequoia: "aefe3142558d77eb7fec459b31f01406279701182cd23ca71e20ef72b04c949e"
    sha256 cellar: :any,                 arm64_sonoma:  "0438daa2f94766bcce16331dc7da60bcd1ef8b4f1449f54314964b4c40958c79"
    sha256 cellar: :any,                 sonoma:        "de16b03b5e76119c6cc725415d3a50498b297c6fc411020113404ca971e9bb53"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "13e44baf28036f97d8d2e24fb1dda75184c5925766f3dcdaad84c6ed8d068d2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "039630379de5f2c6fd78f67fb9c65af4bb358fb857aab6bfaff55ea821df8d5c"
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
