# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "4621bbcaeb90f61fc05728dd32d87bb875a59060d48cf48df0276c17fa5fa34e"
    sha256 cellar: :any,                 big_sur:       "32c7e8d676ff3872c5ac7ff333b375d8d2f1ec61523a45d2ec7dd7ee9ea48498"
    sha256 cellar: :any,                 catalina:      "87164e04258762a688961c7c678c82b3e279abae4239d9733f558765625c1937"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "20c33690ef8518bedd752672c26183578f00fab5ff52e04a5974d700561bfd6e"
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
