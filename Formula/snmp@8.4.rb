# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.4.tar.xz"
  version "8.4.0"
  sha256 "05a6c9a2cc894dd8be719ecab221b311886d5e0c02cb6fac648dd9b3459681ac"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 65
    sha256 cellar: :any,                 arm64_sequoia: "cbbd8e21bced1645934ae75940b02ead4fc680cc74bb42398dbc385a524dafd7"
    sha256 cellar: :any,                 arm64_sonoma:  "1f9a249c3d6c4375badab7682fa538ce8501707060ae36b4649ae8e4634cc7bd"
    sha256 cellar: :any,                 arm64_ventura: "e1bfcf3e84fff628f83277068c297c673b9cd6271622948476b94cd39ce4b627"
    sha256 cellar: :any,                 ventura:       "ef135336aeeeced4e3735daaccc352ee094a8a4597a6a8ce8aa21aded6ac62b5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1ae3067a7faa2b6595f25a96d98bb1389c2de4da96b1d11189056d1e5126867"
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
