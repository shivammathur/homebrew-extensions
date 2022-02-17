# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.1.tgz"
  sha256 "8a4abe701e593d1042c210746104f4b04b15ac98db6331848eed91acadfcf192"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "8d22ca27fac3a7ff5c1102808a5bf2925de10de50c6b83b5e22cfe4cabc542e5"
    sha256 cellar: :any,                 big_sur:       "f587125815c508bf70afb09848b829b5a511e1ec1bf844fe5483d5cd8984557e"
    sha256 cellar: :any,                 catalina:      "e7860e9ea4fd83bd4aca2b8264968e6dcd4d45fd4eb0877e31aa0802b55b672f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b74e4d539579b2f55571ed5e0287979343180456dc5e08ad3d7f5b43bbe16b3c"
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
