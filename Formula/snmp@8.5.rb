# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/01093b7c137d9096a5857cfd55287e01090bb342.tar.gz?commit=01093b7c137d9096a5857cfd55287e01090bb342"
  version "8.5.0"
  sha256 "df473c4d05c026fe281db4f09c292861235063c31e2b13b05147536f341accd6"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "dd94f3c6213e8ae856b57cf6370ae18a6f37eb839a4140dbda28ab182fcf1ca9"
    sha256 cellar: :any,                 arm64_sonoma:  "1e0e3dc037e1eeb15f523010cf5ebe76faf12edd05d50a283d56c59576855cdd"
    sha256 cellar: :any,                 arm64_ventura: "82dbacd49a8205c7c0186bf8d3926c8ca5d8fa593841de7fd7300d936e63dad0"
    sha256 cellar: :any,                 ventura:       "dd5efebe6a7aec2a5ee2cebc22c292a0a192db621ae44cc144a5194c1c99f213"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1aef027d7c4e5aef3219562d0fc45d1423f9fdfaa408cf0c1cad4af94e12542"
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
