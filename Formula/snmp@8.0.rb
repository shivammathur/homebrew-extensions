# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT80 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3df78fd9f89e8356b78353e133fc05a6101b7237.tar.gz"
  sha256 "4a6a9f30a9652f6d44df10c994fc640e48a9744ab91a0ceb990a19d2cd88e1a3"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e95e1a0f9ed2cc7f30bfb8d7cb3befb3c8197409808c1fa25ac21065b9cb76b5"
    sha256 cellar: :any,                 arm64_ventura:  "726844a2e8fff976aafd9c70b5a69f2d9ebded8a5f142eabee10c653b49ad023"
    sha256 cellar: :any,                 arm64_monterey: "1150a0e2dda163e9fa23330871681d73b008e6121e9fa573f8b3867e8f64bbad"
    sha256 cellar: :any,                 ventura:        "29cbc3f69a880713b98bb8c74125e6423275a3f62730dda7505b99d6cecfda2f"
    sha256 cellar: :any,                 monterey:       "77904b353fa3ac2f43f1f45f4f5f7ddc8f05b695ce731068b0f74345f943262c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23aed6609e8e229cf7855916a71a0fa9b9279f758ff8b64bfa2679403f99d005"
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
