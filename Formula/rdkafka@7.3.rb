# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "f5b16e10f7ff43329b0e029fcba8335555ad691c2bb8196c60ca7448b15a557f"
    sha256 cellar: :any,                 big_sur:       "5db89505c4b0e71311fd4f26b97455a91baf584ea4ce9079a165d73e7a025e58"
    sha256 cellar: :any,                 catalina:      "c97462ce1f0f32d6e0af7fc3d8c8b8c53c88955947bef2c48f0d6ff07b6f2160"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "00b9b5f6f198f92c10208cbe054a59b2a1d5a1cf6198cdd163821bf2da1d7ec8"
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
