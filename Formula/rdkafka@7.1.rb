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
    rebuild 1
    sha256                               arm64_big_sur: "5fe5a5213bbfba62bccc579e8b5c844a476a7e776b1a9fe440cd8385ba180869"
    sha256                               big_sur:       "7a517368f3e074e0b0fcdfcc31f1aeaf2885903c0f098bcd12fdab34b778485c"
    sha256                               catalina:      "5ec5fc5cb67358db4bbd42fe2375cd82d74110c76a362c53fd13a6f961d8b09d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65796f3e11b2b29528a6060ca7d6ddd00bac493ab5f6bdf6ba74fc2d742220e1"
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
