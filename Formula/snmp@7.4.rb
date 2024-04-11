# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7c8355c7b92c5f353fd111cc3084bbbdc2a09adf.tar.gz"
  version "7.4.33"
  sha256 "9d0fbd9a49a6b1f29bc2c6b6421dcdc7d683c1f2a3665eb3c99d538ccecb31f0"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "71a4a38539e80c6e4fb9651e6673bfecf4b6c2b6e9434eaef3abe617eedc6212"
    sha256 cellar: :any,                 arm64_ventura:  "c0a3af069cfd6c23e374462e671367bddef25494b63ab081bb9b30063adfe15c"
    sha256 cellar: :any,                 arm64_monterey: "5bc14f8684e29727f4f6191845b7b64c65301f7866d7d1b425d8e55af168a9c9"
    sha256 cellar: :any,                 ventura:        "a4f4b5a5c8fce73bd4008d6ae0e9e8fd9ecf39f1c368007ad3c567f1fda03e3d"
    sha256 cellar: :any,                 monterey:       "5f4abf5d966f2d0285d7a5ab1d1258dc6531309c2751b21e40517d2c94a5e189"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b1df6a2982feee60897db351bc8c4f1b897c5fa882564a0e13096641ee42f9d9"
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
