# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT84 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "5190ddacfa1509a96ce3ac8f7db90452667f30a20efcbaee56b23a86070af067"
    sha256 cellar: :any,                 arm64_sonoma:  "65b277d70bde98c93b16c1381055eb48d2b0329d7806df9b8b5897ec395e1e62"
    sha256 cellar: :any,                 arm64_ventura: "531bfc9eefd52ce60ca9b07e79d62fec8a5fc0cca5bc27137f3a560269a80717"
    sha256 cellar: :any,                 ventura:       "151104090d6d114c5f580dd7d8fc63655777272a45f39c8c3c799872851d6b15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c29e5a6fb315855f08ba9e55acd9e307d8d3010a366eeca1bdf79a4e8d22d38c"
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
