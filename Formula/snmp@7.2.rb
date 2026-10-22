# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f4457d3e8b14e8fd31f70dde5b19e6799fe71538.tar.gz"
  version "7.2.34"
  sha256 "2beaaef99d934c31390a83e51dd61f981004fca474aa4655573292409ce83ca4"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "38e9686bb294065255d4e47082d9c858aba1cf5d785321044226be05e7f7bff5"
    sha256 cellar: :any, arm64_tahoe:       "6b17a390ab54315de7baf072b5234ebfb485ba678acb49c681483a8c8d9941b8"
    sha256 cellar: :any, arm64_sequoia:     "e01e468d128d78dd4520a70c952deb725bf594cf18745ea4522a65353897019e"
    sha256 cellar: :any, arm64_linux:       "c0dd506b35d98acca29cd04822f9c54baf2881dd5dbf46da3fa0d15f8bc68e43"
    sha256 cellar: :any, x86_64_linux:      "3930fae8d63445a2ab6ba27cc9f6d6f0e40a9e9b94eaf3d6f8411da0bf0127f5"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
