# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT74 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/e5b417c927f43ba9c4b237a672de1ec60d6f77ca.tar.gz"
  version "7.4.33"
  sha256 "7f9b8e85407c223c3a45e11c1bb4fbebf66ef7c9008277eb1ddba2b5d1037384"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sequoia: "4f75b37aa6aab42fe6b67879f609d880808ccb5a437e764691cd4643d8825c3d"
    sha256 cellar: :any,                 arm64_sonoma:  "1af61446ea362fe8dda0f69013887027bfcd3091b0b91d7713f8c67b77b1026f"
    sha256 cellar: :any,                 arm64_ventura: "9dcb64726d821c76c69cf10f05153b300b41ab0a290170706e5253fce6d57beb"
    sha256 cellar: :any,                 ventura:       "5b5a7468b22aa67db1b3690a09875fd5b204b843e34140c4b41478c534886bd1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1c955eef6d9e600bfa43fdeb03170621a00a90b779a780762aff4edbb0153afb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba4e596177cda56ae2757b284e952f722791b4a88170ca776c9701f13d7b7965"
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
