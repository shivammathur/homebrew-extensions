# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.1.tgz"
  sha256 "8488988cf210e45a9822afdc35868cb47909ec0fff258a2f9f4603288078fdd7"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "6081da2e1ead8086753198e5eb7a545a0aec6ceb64631ff75e128f19880fd9d3"
    sha256 cellar: :any,                 big_sur:       "f2916e4f543cd8c89a0ff9e0eb432d236d4342de489dccf3ccc0b9a6fdcab4ae"
    sha256 cellar: :any,                 catalina:      "94781018ad0b5778303fdfb9c67a7d370da54e24c57da9b705bacc04487d33b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c59660cbd194bf7590cd2ad8c6e5d6495d6a793081ea75acddf0d01ce78f8e0b"
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
