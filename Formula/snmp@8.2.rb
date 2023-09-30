# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.11.tar.xz"
  sha256 "29af82e4f7509831490552918aad502697453f0869a579ee1b80b08f9112c5b8"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "fb84556729231d877fd2508bf7eb28fc0068166c116faa1df5a3c261d3157956"
    sha256 cellar: :any,                 arm64_monterey: "166d51322ee164beddd779b42881ca12aa88a57e1c0ea886f2863d74160071a8"
    sha256 cellar: :any,                 arm64_big_sur:  "262e544f140dd827c1c2b1ac32a7023ca85b99af122d70b3e2960b8bccd0bd33"
    sha256 cellar: :any,                 ventura:        "3fd784affd83a3070200fecaad7e1be3b91c2afbdad7f47567a9d24540e3bcaa"
    sha256 cellar: :any,                 monterey:       "8b12568d9bfd5a4b093c9571aa8fa8fc00cee49103ad803a833c8f6a3b8d6524"
    sha256 cellar: :any,                 big_sur:        "405e7fbdc6b5d82a7d6882f3b0888fc79a690c52f27d8c187dac560a478df506"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "699e934e984bcb5b1ba56edfdeae128cee1b64d46f9b57f46481655924d18095"
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
