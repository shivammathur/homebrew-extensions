# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4077dad871377fba8fd66d1dddb6741adaa6212e.tar.gz?commit=4077dad871377fba8fd66d1dddb6741adaa6212e"
  version "8.3.0"
  sha256 "43693c7dcc9f78a4a05939ea516061d0a326c531310dca2f902b504373fc6313"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "e874e16539a4a1ba5688c5c1113ccd87531b91db0d84c77663e26bf296f06b51"
    sha256 cellar: :any,                 arm64_big_sur:  "e853163f46b81006f9cbdd1e548d4aec02bd6b1a0ded0aafb4f9bed1b23f520a"
    sha256 cellar: :any,                 ventura:        "bc76889845333dbf3784a86811082101eef97b24495911193490936921fe5dd4"
    sha256 cellar: :any,                 monterey:       "c78798fa4781ad1a40917ce0a4b42179420cabbfb24fe363ee0dcac186d986aa"
    sha256 cellar: :any,                 big_sur:        "c464e84a789a6ec3d860f893d1ae066b086392debb99df0757df93ca78f16f0c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "087cf5411bed18fd160ce775c01670e603a9549a9510692d4c6722da58527550"
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
