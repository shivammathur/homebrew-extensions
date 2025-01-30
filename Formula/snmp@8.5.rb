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
    rebuild 7
    sha256 cellar: :any,                 arm64_sequoia: "75e589bc05b5024e9a8815056fcbed5082b6b2a7d2601c922702cf65cd4347ba"
    sha256 cellar: :any,                 arm64_sonoma:  "d7fef05c69756d85103173cb3a08031dffa8c74ad4e7c28f13dba64931fc3cca"
    sha256 cellar: :any,                 arm64_ventura: "6c97f6fc34dac02004a9c882582d0a1412a13347e3777e226f06fa93a4313f03"
    sha256 cellar: :any,                 ventura:       "b2ec5cfbbf38b3b9a41b366979d5b554841003a9e712017109eec95fb2eae9c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4dced7378ce32f493a884e2739a32b3588aa5be4a048e1e7154e27be0423a458"
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
