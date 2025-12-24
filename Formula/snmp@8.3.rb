# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.28.tar.xz"
  sha256 "25e3860f30198a386242891c0bf9e2955931f7b666b96c3e3103d36a2a322326"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.3.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9b98a890a7f41ee4851b6512b0de406a5a14b80433ccccf7c2c405b7cacf448a"
    sha256 cellar: :any,                 arm64_sequoia: "6871871cafe906f010ecbfdf529eecaf8a2491c5687c4e37adfaa85cb472ce79"
    sha256 cellar: :any,                 arm64_sonoma:  "9be011f276260b5af3ca0a079c76f923d750330fa37997b117fb6d3ac19da372"
    sha256 cellar: :any,                 sonoma:        "8bcd295beb71373d3a9b69d1ac890629f5cef0dbd0cfa83392ebdb4fe4c99fc1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "421f0c06fe8a441cdb49d8a8a01794e9642024ec89cea891964b0b5b8ced5dfe"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "272b13bcb0f8b33d76ca10a9d7bc8bd2659282d7bcaade282be93d4b05057370"
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
