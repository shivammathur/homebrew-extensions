# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.7.tar.xz"
  sha256 "e29f4c23be2816ed005aa3f06bbb8eae0f22cc133863862e893515fc841e65e3"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "d081c7bd97dfd45431306847a05ebf7c856ad510fa9a7f07fc5ee2edf736d952"
    sha256 cellar: :any,                 arm64_sonoma:  "8348660a31aac9dd9b9351ceb4fc33f0e9e2b8d1c62821b41e1912b34f439235"
    sha256 cellar: :any,                 arm64_ventura: "ef007b539e3e80aa6b2fb47943d153693dacd1f406d7fa4b91d23590192ce6c9"
    sha256 cellar: :any,                 ventura:       "cece161d6de0bcf0b2d8a00eea531fdf6a36049e1cf950055bd6c0daf3827107"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "386fdd22a564b14b60b884eedc3fa5c143d281236994e121ecba8a0e46c3164c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b2da6335e7123a197353966f14b7285a1eb9d7912b213749a96eecb53d007cb5"
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
