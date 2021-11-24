# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
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
    sha256                               arm64_big_sur: "82081cd78bc53bd813f25078105afaa0b94bf424527d36d3950d80c6b944087c"
    sha256                               big_sur:       "bd8997e419913a9aa26f013461e3331dcb0325884c4315bf611635eb2ef3d95b"
    sha256                               catalina:      "5d205e71710e1efe912524e7dd5c32aad4b2d4fcd02f00aabde257293830b336"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddaf8c7f38b076c740ca84385abfd9c701f729452b1f959f184e90d367f22b7d"
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
