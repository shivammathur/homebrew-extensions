# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/20a8b119f45d569e6bfee5d58b88e03579f8cb8c.tar.gz"
  version "7.3.33"
  sha256 "291acfe57a3859077f03f3fcb6d9f5d0cbc050490f9301d584db22ee5b9e5dd4"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "5701de8096553eaf1caa97d2742e6f48398879210105cba49dadd3b9ed6df197"
    sha256 cellar: :any,                 arm64_big_sur:  "93c4cccd7954f39b5e6e02165a1214cf0ca31f55a169501945a4582b63e7bf3f"
    sha256 cellar: :any,                 ventura:        "39d0cda8c6cc1bb1da1b9f0872cc0e28e7128f970d4360b2894a745bb9e71bf0"
    sha256 cellar: :any,                 monterey:       "1248dcc83a17ad5929a7d5079a71317a75d99c851a82854ea767558b63328339"
    sha256 cellar: :any,                 big_sur:        "358e13f0fb036f0df54f7407f6fd0de72907aa0894614e8ef1d578ac1946e958"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "77f4a263c468b933244b9a00853941f138dad4abdcfb3519b162b117c0f08bff"
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
