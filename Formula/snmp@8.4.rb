# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/e1630381b75c960cdc2ba83836be39fed88e211d.tar.gz?commit=e1630381b75c960cdc2ba83836be39fed88e211d"
  version "8.4.0"
  sha256 "5fe62c928d5c0ae6ef75a6f3fd99606cd020751f42f45ff4fc54eac09285a60e"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 33
    sha256 cellar: :any,                 arm64_sonoma:   "5e13d5aa2414347371538375d62ec32bc872b9eb6e7bcd9a896588a847999c24"
    sha256 cellar: :any,                 arm64_ventura:  "1a836c47e0eaf9c11a658d034a99e962f85852c6098988a17f00b2518fca30a9"
    sha256 cellar: :any,                 arm64_monterey: "3833c42a3fecdbd6695d39daad2cf2b042337de523efef61857f4e3be25566c8"
    sha256 cellar: :any,                 ventura:        "ecfb9ac30d451627a2c35ff13971638da8e718bf577e050fc7ca8e6c6b514ea8"
    sha256 cellar: :any,                 monterey:       "0d6d498d9c4774aa625ab961fb161458a004d1aca35986b40411d6ddd0da7b14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "49e750d8b51403b7325a952ddfe77bebccaffe5823e10687ace9aed66e52c860"
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
