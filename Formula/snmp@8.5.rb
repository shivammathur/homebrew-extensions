# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/8f1a627e7998de024f8414f18d0f02454b7d74a6.tar.gz?commit=8f1a627e7998de024f8414f18d0f02454b7d74a6"
  version "8.5.0"
  sha256 "6cebefdf3f292f0e801d4b664761862a137c496b12274a20d30e3023b8683943"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 38
    sha256 cellar: :any,                 arm64_sequoia: "c16098d89362b89a5dcd46caeaf68e4129b4a4753abba7533795a91b6e9ea2de"
    sha256 cellar: :any,                 arm64_sonoma:  "6334fb59cf101ea313b08d4c4efc43c53dbb82e5c934e294950fdaaa0f648ec3"
    sha256 cellar: :any,                 arm64_ventura: "5b3cd8a64d66bc9ff9b586115fe7f396318c4005b5e4701c95ec57aa7c8e0ce4"
    sha256 cellar: :any,                 ventura:       "4c3d764ab6ccfd8be5df1fa8886b393ce02c6eef37a64f9392dfa946e1604668"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "513a5cc0f72c9d2ccd9829d29df1ff06d28058aeb247043ca8360a57e9aeae93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "401f0dc16e0074ba47596aa3b35686f8b87f2debb58c4c5d5d9d134db7eea9b2"
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
