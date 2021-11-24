# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.1.tgz"
  sha256 "8488988cf210e45a9822afdc35868cb47909ec0fff258a2f9f4603288078fdd7"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "505a8640929f3a902b32585375401c49ce0d1cfd929f10dd06a432103bba35bd"
    sha256 cellar: :any,                 big_sur:       "ec49a0b6d20e2b0eba17a23798c020f58540972cc426aac6752d535176c397c0"
    sha256 cellar: :any,                 catalina:      "9cb0c41042f130b278b527fe049e4d23d523aabda43c5eee836d088d970e07cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "216a4f3b6e9572cd5c63b65167ab8e89f4d165afa8a6f0252dfefeb8a58a198c"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
