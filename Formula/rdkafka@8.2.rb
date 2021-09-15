# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://github.com/arnaud-lb/php-rdkafka/archive/e570ef17571f22ec973094904e0854a1871bc4d1.tar.gz"
  sha256 "7c7f5225f6a87826da67eedd2667cb2dbb970d698b1437efa5b18c45ba495be4"
  version "5.0.0"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_big_sur: "e7d206b153d53dabcab5f8d75db938594cad452c1fda4c564ea76b6b845dfe96"
    sha256 cellar: :any,                 big_sur:       "ba4016f4d57205b479623270876f9ceba9db42c19580004594c253f8e0250e3e"
    sha256 cellar: :any,                 catalina:      "9d5864d1bd0fd06c3f09b046a77b220098474d93ac0b5550dca2838ed60961ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "825f2e4ac247b14d09315701343f5a1f799646e5092e55911c30586989cfcf14"
  end

  depends_on "librdkafka"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
