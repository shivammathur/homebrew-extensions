# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.0.tgz"
  sha256 "432fbaae43dcce177115b0e172ece65132cc3d45d86741da85e0c1864878157b"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_big_sur: "648eab2af9fb9519451a518d351b349943de7d6e84082d66966efed336e2bba9"
    sha256                               big_sur:       "5c09275b8ae36006e13150498834fb679c0c8221dcacbe4bc2bcac469ea8cc73"
    sha256                               catalina:      "6817667d6d97b28c03f3e362a7a46384198fdb9ff7a219194a0e0795b702bb97"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba28c6337090bff2f0fe8e5fd69f20d0e45265e26388ced80f88cd9011a24b41"
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
