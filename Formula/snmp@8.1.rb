# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.34.tar.xz"
  sha256 "ffa9e0982e82eeaea848f57687b425ed173aa278fe563001310ae2638db5c251"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "3a6aec11de4d19855338962538ea4feb1ff9c270f0a0d9c505c650b9e07c46c0"
    sha256 cellar: :any,                 arm64_sequoia: "1a519eb8349a1532d553a53f878a5bb3a7f37e930fb0e60a8143a579bfc9700f"
    sha256 cellar: :any,                 arm64_sonoma:  "7ab96e031411a6c4aa642e73a344e6ad113e472fe5c11ec06e8e707487864d77"
    sha256 cellar: :any,                 sonoma:        "66ae70237c4b399ad781d9373dc5c5df5df09d773fc15bba940017f43eb2bae8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7f7a121d3a8287f6dd646c179689beb7ef2b54e20e8585e2b50c60631f9ee4c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1cca9f019ef13e6fbf73e9846e6ac54779454e059e8584937e19f43a8f9f4c85"
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
