# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.24.tar.xz"
  sha256 "388ee5fd111097e97bae439bff46aec4ea27f816d3f0c2cb5490a41410d44251"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "08db141a566a75e4b9d2e19aff8494f8433762b3bd733896f6e74455b635eb32"
    sha256 cellar: :any,                 arm64_sonoma:  "7e83dff1a74943916e046d39657b2cf9a1ac9014300babd44707094ca7f710d6"
    sha256 cellar: :any,                 arm64_ventura: "00133ad075cdfb8aef661a1f22310afc31740339c036b3a7d7bcc2cb0f129274"
    sha256 cellar: :any,                 ventura:       "f6ad4adb249b49a2f8b35162469d3255d46a6f16a4aff45be57fa23a3ad2b497"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "59d51dc171212edeb8c16e5047a39d6644ddbf3557f50878f6770d964fbae9d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db87fa508554c6c24242197120cae81e51739ac4e5bf3aa2941a45a12d1556f3"
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
