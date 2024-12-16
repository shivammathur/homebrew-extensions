# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/6e8642559e91f9f4321f9b8be3d4bacb1ebffb71.tar.gz"
  version "7.3.33"
  sha256 "20800afaac39c391c9d314a076160ffc9a7542149799b5688bbc029721b67cb1"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia: "53f8fe26b83efe8422eeed6fa95c8a3064b52fe5ba12f08cfda54ddf8ebe6f56"
    sha256 cellar: :any,                 arm64_sonoma:  "213091217ee8e60654ea76032ca851918171ab6da219624f420862170e8fc80d"
    sha256 cellar: :any,                 arm64_ventura: "2d2b2234d16460fcff07ad21af4d4f32b5db13a281d58c91b36929fbbebacb2a"
    sha256 cellar: :any,                 ventura:       "8058ff184d71a5423fbf90bbaf1dfdb18ec170873d5b53b0114feb91bb8d3594"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e2e78130bf4f567c1bed89d69b40fb6d539cef4a0eeb8325a58ce15abb9af89c"
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
