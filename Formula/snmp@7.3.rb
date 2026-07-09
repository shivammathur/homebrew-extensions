# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/64ca21fc4a956b8d2c151943dc22dbedb889f01d.tar.gz"
  version "7.3.33"
  sha256 "ffe700b4ddaf86b580bd5176bdbd2bfae785b9eb6786dde06afe6ce77e665ca7"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "12b6491c3959a469285ec959373db42ede92fe2713e97099d58aaca51413f8b9"
    sha256 cellar: :any, arm64_sequoia: "ed6157d47153be619190472650012397bdb28ddf2a2c69dd936323105f3b6c0c"
    sha256 cellar: :any, arm64_sonoma:  "cc1a003d156cc3fbdfa8e64f790563e796534440f7c25106d1458df1decf31c7"
    sha256 cellar: :any, sonoma:        "793152ed2355dc6cae21b55402de1f253371210d3e62d92d156521503501d155"
    sha256 cellar: :any, arm64_linux:   "b9e9d1d6291fcf12487b72857dbf074268e383c8e848381e3bde182910ea4161"
    sha256 cellar: :any, x86_64_linux:  "6fced3d6e0196d525481b2785fdcc51939c834adec2097891b31331877344957"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
