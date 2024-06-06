# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f77964ef49a459f67561517cd77292ec505a03f7.tar.gz"
  version "7.1.33"
  sha256 "f4e0826d2fe16ae4dc9d6b7b54a0c24488fb1b66c8202f8a0c27987a9172ec61"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "56e034647320d6b942f438fb2cf9795cb10aa12cd2181dadb9d32078f19b9b63"
    sha256 cellar: :any,                 arm64_ventura:  "deb43e429062dbc4c025fbebf951467f03456c5aedf5b7f16aae8740ccdfc097"
    sha256 cellar: :any,                 arm64_monterey: "b3e79c625ba106dd5237948ba74b4eac21af8d3350a5fb5d27599fdead259987"
    sha256 cellar: :any,                 ventura:        "de46dfacb1a2babf544e7e41d5641394b43967d6293341fc6e6d21808ab7c0c9"
    sha256 cellar: :any,                 monterey:       "9d77879b234d02b9531650206b66ba754e5d84733264745ddda4b70b716cb63b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a58467b7caf6396d3ee4cd79cb52c09767053eb61b5722299a91d4798efb2107"
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
