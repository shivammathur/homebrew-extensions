# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.2.tgz"
  sha256 "b250b0b6df32484e59936b676983ba134376d15652f02552b2bf0482ab2cbce9"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "1e6b14e58a4203cba86b1332ad66307eb5ff5b6936ceb72adebe2a37e11df2db"
    sha256 cellar: :any,                 big_sur:       "da2fb7b3e6e9caf020e138b01e4b77e25ab625d647aae761485cf657260d7454"
    sha256 cellar: :any,                 catalina:      "a3104845de6b5fe906bd61bc400010771779c52614a38a3932922f8df0edacda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0d0f82a38be2bf3c0d680b08850144e78d17f4becde2a778917575220e1babfa"
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
