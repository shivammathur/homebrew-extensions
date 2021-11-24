# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.1.tgz"
  sha256 "8488988cf210e45a9822afdc35868cb47909ec0fff258a2f9f4603288078fdd7"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "b97edc418ac2378819fd63452eb047efd590ef0dd719d9eda6d9c5738b3e69ce"
    sha256 cellar: :any,                 big_sur:       "f6afa2014cbde3f227166fc19996bada99854b19fc068d36ee702e2d9deff766"
    sha256 cellar: :any,                 catalina:      "7ffde819bb6b4be7651de397ad463dc7793de4aa74ba1d427acfc6bbc9fa8033"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "59dbbfb9ccc64d8a0a4f1ae6638ac646d0e0094a09422622d068dff274eab6ec"
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
