# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "5cc044feb6e53003486f72ac201858aebe3659f4cbb3188ed5abd2469440eadb"
    sha256 cellar: :any,                 big_sur:       "5eb71f9b1bfe61bd0f9278b157ff99ce55f7216219dfcbc4a43cefe8dee4e8b2"
    sha256 cellar: :any,                 catalina:      "c2a465f64c1079dbfc74f7cb3fc19651726a12ace90f2898cc425075e9198335"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8004d9377cda34a0595c497f2616acf0a6f20d19fb450ca239e677dfa3079946"
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
