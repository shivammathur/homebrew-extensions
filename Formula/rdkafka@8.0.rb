# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-5.0.1.tgz"
  sha256 "8488988cf210e45a9822afdc35868cb47909ec0fff258a2f9f4603288078fdd7"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "ab0c505d66c407b7d94aabf0d52f4cbb0dac6f9034737ad2b1c763c52bd8f060"
    sha256 cellar: :any,                 big_sur:       "f9f5563ef8fe07e52864a71ea87f5b26efb682983dbd21ad6a00a6f875ba2cbf"
    sha256 cellar: :any,                 catalina:      "3303e03fb64451871047acc8ec4e9fecd0e48ac38e4c0163126f90f53177d98e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40e1987b75014dc86a6668857832f0ea1cac2690bb3a6357ceb5752a0444b1f6"
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
