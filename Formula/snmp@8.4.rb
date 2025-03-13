# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.5.tar.xz"
  sha256 "0d3270bbce4d9ec617befce52458b763fd461d475f1fe2ed878bb8573faed327"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e38e6e83fa3b00a2b4cf962497873039b1f9748141b8a287183e2e21f331cbb0"
    sha256 cellar: :any,                 arm64_sonoma:  "77562cb1a435da42145cbcdce9b9f84cfe52f109f6f89ef96946b07456c24a67"
    sha256 cellar: :any,                 arm64_ventura: "52118a0bbdf3cb63833ee8f62dc8c8a150aef36d39f55c5c4166da9498ee57af"
    sha256 cellar: :any,                 ventura:       "761ff8cd9c3bd2bccf02670f953803facc068c5ac537e33dd6b73c9eacd4e6a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7464502f302d0a34a9dc429c562d2124389f7bc42817cfc2256e10a27c929ca"
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
