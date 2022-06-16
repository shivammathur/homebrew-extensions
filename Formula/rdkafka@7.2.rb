# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "649c9e85dd9b83bfd4559450dd6177c7e819c01fbd398fd25636d3637dfd4d4a"
    sha256 cellar: :any,                 big_sur:       "29b0518873e3b80b6b7a5f61e14e20cf4d83e67e07994fd9d21ffa755e9e33a0"
    sha256 cellar: :any,                 catalina:      "163992048c5bf7ae1e0c0e4b06e941b7c6207fa70256c4630bed7a833d0e032f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6e9bc001f92c58179cef8973e8599e0f40759a2780125b33328cb78b7bd0cf20"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
