# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "b737a3ff9e78982a24f7f1e45e23e767101dc7e8c83a943248e302d33d1112ca"
    sha256 cellar: :any,                 arm64_big_sur:  "b0e57d465174755707aec33d4417782b017d886699f93c0b4b16170ff09f9f2c"
    sha256 cellar: :any,                 monterey:       "97c1d6a0c7ba842d2379ab88f03fd4836582d5e7a95db0b72cee6b5e111b2761"
    sha256 cellar: :any,                 big_sur:        "91e8362fd9f6585bf206ed7674b5f112f087a8c28f94c723cbbd893aa77d6b6d"
    sha256 cellar: :any,                 catalina:       "08aee296fe5649a9f8fac43b8f199ebc0df684737996903cbe0375d463b3e161"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8e70446d338f147957811332e98251ec2b6a9c1af6ac8b48e634910efb10f62f"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
