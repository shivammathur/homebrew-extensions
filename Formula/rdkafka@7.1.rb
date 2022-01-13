# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.0.tgz"
  sha256 "db89073afa27857bcc9e731f7b7fdf0d81c69320fcbe7b82e0d6950703fd4d8e"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "dbee61351dd37a1f552f2a3f3520f9d09b737261a8f231362b5c4debfb2aff4f"
    sha256 cellar: :any,                 big_sur:       "36e1a97fbfd98f5f20618aadf2ca7d17c62457a6c9b325f2112d3e0da61b4ac7"
    sha256 cellar: :any,                 catalina:      "b0a51817534031689f08d914bfbd02462a777edbafad20f34046d8aa13b5b052"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5bbcde2db80755bad87717e906c0a1ba95a29ce019d2b5d50bb5b46dba1308eb"
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
