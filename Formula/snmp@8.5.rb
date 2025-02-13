# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/65d433161a2179d7a69e857280c581d6f8df18cd.tar.gz?commit=65d433161a2179d7a69e857280c581d6f8df18cd"
  version "8.5.0"
  sha256 "95b6530262c84adc129f8d3532fe5dc94d2f03af670b22d58ee826dc3e7ab7c2"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia: "5c357871128bc0432c07ac0839e8d77898c2c962a937202548fc19195157aff3"
    sha256 cellar: :any,                 arm64_sonoma:  "210b0409c8bddf2e5f6091583a8e76bd74857dc0698dc5cca5148aaedbffafdb"
    sha256 cellar: :any,                 arm64_ventura: "757cd3bde7412afd9c344a754c482c942416acbf37de116fe5f89dec31b73e64"
    sha256 cellar: :any,                 ventura:       "91451beb2de8ee5684d21e846235791cdf4ff01fc15595953bfb88b8050a896d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "694357b713ba4a4021e3e2324741ba627d94e916b1269fc024a9fb3fab114443"
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
