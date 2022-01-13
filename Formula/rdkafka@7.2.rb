# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bd177f033f4e70a6940d8d4a09d03ff1790ad7a941701fc65cc408746ed5e961"
    sha256 cellar: :any,                 big_sur:       "61babab7c2b96d774827e98e43d12c362eb9ef86a0b8fc2e432966035aa2b043"
    sha256 cellar: :any,                 catalina:      "bf8f7966be1ac7ffd308ddf5ebfecb3fe09da9cfa9bf2cf0174492ce2d297722"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77efb90c825b8d9cbf047802011daa1d48a289d6251bed4ae2bb8333cdc3e6fe"
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
