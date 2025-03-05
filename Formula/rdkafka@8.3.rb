# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "5142a2f1f3d2e80e763623a0afa61a7b0b717232b65844f0b0b90df6e783baa1"
    sha256 cellar: :any,                 arm64_sonoma:  "656bc707c7779c6331b69862290337f67a22a8586ea1875848d02a97cd1b19b3"
    sha256 cellar: :any,                 arm64_ventura: "23819386d9416be99dfb5cb7ef95b79696b3ec07d32063e1f5d5085b8b8b49c8"
    sha256 cellar: :any,                 ventura:       "aec30a5a97df9a87b3284a92a4a5237921829a7d584137ed7c47bbafc039d307"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "153890e56904eb8f8df9f7d4f48115bb9bf22c2096bec64ab1638bfd0c14bac2"
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
