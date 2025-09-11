# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/2d545dd1b765e062205cfab1c1594b3f70e163ef.tar.gz?commit=2d545dd1b765e062205cfab1c1594b3f70e163ef"
  version "8.5.0"
  sha256 "ff9880e2a90998ee1e1e501dede3970303b9fcb9cb52862f1ffcb93533fac848"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 43
    sha256 cellar: :any,                 arm64_sequoia: "514078374170c4e0f0414ae696a9f058fd5993b7e9bb1af959730ae5a68270f2"
    sha256 cellar: :any,                 arm64_sonoma:  "8ca7430fad2352af4b3b5eb5ab82ee6e089f697bb7b2fffbc92ac5310b5f1004"
    sha256 cellar: :any,                 arm64_ventura: "f44aded367f2b063e44405ea89b1fa69bbea48c79527da5705026a4cdcca3e1d"
    sha256 cellar: :any,                 ventura:       "c368a760942052c6d6be22164e08c7bfa056dc9e30bc3d9a78cb808c535e6149"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f60b0d342e19251da4e81d17daf3222c4f2b363009278e355c670cbc65f6e762"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "22b5465ba1ac0810439cc8965b2b85f7c7a068c7a33a404fff8ec776f8ba6c51"
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
