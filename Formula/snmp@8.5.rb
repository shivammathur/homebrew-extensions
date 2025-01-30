# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/6f4579af85ccb18530af7464ab6ad44ce966af96.tar.gz?commit=6f4579af85ccb18530af7464ab6ad44ce966af96"
  version "8.5.0"
  sha256 "fb0f990c627317e15e47c75ece00cfe826fb32810f28ec2a2c63fa2ceb8547b2"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia: "c9180215b2c9c2afe77d845d8057df2aa982bbdb4397f66eac4fae5e57de38f1"
    sha256 cellar: :any,                 arm64_sonoma:  "01ff354dc6ea50ea31d187906afcfcd2d36ec9f0970b809af4ce6305b4d741ba"
    sha256 cellar: :any,                 arm64_ventura: "12b013b29a6f9006baade125e1e9d9e62945b1ddd61754198077258bd4aae6cd"
    sha256 cellar: :any,                 ventura:       "c5e8a6c003d72f48c8474a0aca97a2bc65239e138736ee6662815faa35b27638"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37c0ac289e47c6336a700ed29457909af866ec83eca155370e35e949bed1a5bd"
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
