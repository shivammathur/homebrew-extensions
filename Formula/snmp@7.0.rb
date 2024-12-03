# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e74d83cb136282e1fda676bf22a7cc7f5578626b.tar.gz"
  version "7.0.33"
  sha256 "a40f969f584fb35b1caf1d2f5c45dfceee92f7e9d8e61b26b806f7537c5c645b"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "520bad94f5a7252e67b7faef81035b2f847a16a450e5b10f59fd7e080f76b56e"
    sha256 cellar: :any,                 arm64_sonoma:   "7d14f7763958a87acad31892218672ebaef773de75c3f950c3acbf57ccea1cbd"
    sha256 cellar: :any,                 arm64_ventura:  "ff06b8a4a3c228f504936c552c17d5f0f53b4e8ab267b012987a78e95e45a918"
    sha256 cellar: :any,                 arm64_monterey: "1948d97f4d3ce682c342dcac6126ff8f6318400d02d40bc2d1479553e0e2ce99"
    sha256 cellar: :any,                 ventura:        "4d9652fa436d371a7d9e13b09f0da62c48a18a1f05095cab2a97602400e67dad"
    sha256 cellar: :any,                 monterey:       "f6becfecc0440b2cd25f547ca27b751dc75effa2f0ea6c28ac963c4458e40a91"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6eeb8cbf6708aa637bf25da0b94a316dc99c734d394c8c5cde8c72ceb5785f22"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
