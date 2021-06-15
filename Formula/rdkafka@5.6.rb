# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT56 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-4.1.2.tgz"
  sha256 "8ae04c240ce810bc08c07ea09f90daf9df72f0dde220df460985945a3ceec7fc"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 arm64_big_sur: "849ee8b4808b7ff49e7e0781ca22f0bc89e46546e7bd3f89105d329f5d6d0713"
    sha256 big_sur:       "3962db198bf43144d90a336bd29efcc07e29279b5e51589c01640c294c534c23"
    sha256 catalina:      "c59ca4bf1e11fe710668c864a1db4b46b8a269d7ea8f1e0a4a3e89de932025a9"
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
