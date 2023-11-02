# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5e12756ee8e1682149440494b4aed81af182fdb8.tar.gz?commit=5e12756ee8e1682149440494b4aed81af182fdb8"
  version "8.3.0"
  sha256 "d85a243e1af1d40279377207efd95578834cc0633aa2206ed41aa7124fdca5ef"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 19
    sha256 cellar: :any,                 arm64_sonoma:   "1059d3553754553b6e584a22cdb7bee3da78a768d7375d67a18eb029fb1a7d7b"
    sha256 cellar: :any,                 arm64_ventura:  "e2c8707bf64105f214a5eb7cdcd416c6a8fc27ee4a4e257f13af13b03af0ec1b"
    sha256 cellar: :any,                 arm64_monterey: "edfc816b247708a9261e4ee63c87ba82612e14d5505f20d2db85e3782bc1e580"
    sha256 cellar: :any,                 ventura:        "328a14ed3620b0cc0bdf5363afb4c323673693ddd94699a6e8ac896bfc7a6d65"
    sha256 cellar: :any,                 monterey:       "2fd612de605a0361d0bff73da718b8ff447847348f79ffd621c4a1dbbf704c38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc9af136aab1cc9ba084bd91d59681caf3ca1de0fa41e02ff69db47700258847"
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
