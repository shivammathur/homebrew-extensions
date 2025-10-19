# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.33.tar.xz"
  sha256 "9db83bf4590375562bc1a10b353cccbcf9fcfc56c58b7c8fb814e6865bb928d1"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.1.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "be2e1e3366ce197413bef2fcdd2711fe272576acafd9fce5fd13d18e3de565d4"
    sha256 cellar: :any,                 arm64_sonoma:  "15187e624e507fae256ccca55eaed3d218ec320e9320465bbea8f3c63437aedd"
    sha256 cellar: :any,                 arm64_ventura: "f3cfaef9e6d1e445dd294f6598493c07372f8803a93821ae935246c3a0f56df0"
    sha256 cellar: :any,                 sonoma:        "04bda7701924dc382027e6fbe3c7067087d5f2d10e014331e15ed58c56133003"
    sha256 cellar: :any,                 ventura:       "9546dac69b78de31cd4a4cb9da46b8a2ba283d5f065c7564a491b117fa8bc4ca"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1133aedb9ba015625de03a7f839c5e86e359247b15a8783073cb451da979d0e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "371151b784daf052b69c88f1b8d0c486c67cb6f787be572c61f003b9d6e5822c"
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
