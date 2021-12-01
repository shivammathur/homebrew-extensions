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
    sha256 cellar: :any,                 arm64_big_sur: "7dce32fb32cd23d459f04cd6176b65d1ea2f720746e5bed26e6bd110ac3b9870"
    sha256 cellar: :any,                 big_sur:       "5b449b93910e686ec1728f07ec603f76d58228a47f9056afd24655a7eaa86c2d"
    sha256 cellar: :any,                 catalina:      "143000e752755f066f81152bb3d2977c7aed57b54ecc5476588bda4cc52fdfac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "80b3b653f97a6e9bbd895d4d2ea8f15e3e8b73c57d831cec4f1bfbbc8255905d"
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
