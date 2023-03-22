# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.4.tar.xz"
  sha256 "bc7bf4ca7ed0dd17647e3ea870b6f062fcb56b243bfdef3f59ff7f94e96176a8"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "4530383e79fbb1b89d61699a1ba7e8334bfdde8e6f611a82627be4666bcccb2e"
    sha256 cellar: :any,                 arm64_big_sur:  "dd417f1cbc31ae91e1b5bf1b9073122e64efe82a8584c10252c9df87017edacc"
    sha256 cellar: :any,                 monterey:       "0d20a0b779d43c595637bf6e7198bbab605c85d06ecc8777f8eaacc288154460"
    sha256 cellar: :any,                 big_sur:        "6454e52cb9eecc9f7e1fdda2d02f963d020106ca8b18a0c28eb2ffa5cf5b73d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7cd5f56e1a2f19f53bb4090e3a033b695260a9aa8dcf0ab750df66a52bfadaba"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
