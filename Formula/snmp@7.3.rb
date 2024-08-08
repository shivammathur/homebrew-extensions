# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d4c97291002d9269dc54bbdfe7e784f8c5f1828d.tar.gz"
  version "7.3.33"
  sha256 "82cb09a0ed82e88fee690da288df8a878c8db2bc0991e796559dd79c5e05c185"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "3827a5fca6c52dc5ab1fd3f7cdb64c819304a9deafdbbb7605e22badb1edfb60"
    sha256 cellar: :any,                 arm64_ventura:  "88526dc4f9cdf35587500f7ee1aa11cacd09260d8dfc487c04d2ce1a4e5be3ce"
    sha256 cellar: :any,                 arm64_monterey: "e5fe5fd7bf0159ae16da88000ce82ef72b257b9994db0d987313eca53e03417b"
    sha256 cellar: :any,                 ventura:        "70a331806e6e782b0462e10bfb4874860f7f52f2ec0b6a5c3193d64544869481"
    sha256 cellar: :any,                 monterey:       "89460d9cddf01120492bdc585ff81cd632add20c8dff44906f06b768e35f7bea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "066ac37ad65a54a9c64b03d0cde31d4e2d8155f480cfc48ca36d9c6793498213"
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
