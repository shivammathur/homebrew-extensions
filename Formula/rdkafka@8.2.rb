# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "aec9336326ca29fef3f6d002f7bc2f5126b74ee5ffbd491b3a5764db16d2f6e6"
    sha256 cellar: :any,                 arm64_sonoma:  "a5c68cb62c84539765a7ae56c999ced8b585cea11b960e6674b94676e530247c"
    sha256 cellar: :any,                 arm64_ventura: "46ac5bcf8ba5a13e453a2b02d54d90e758989fc8c757fb4a3f5a1bc50587e1dc"
    sha256 cellar: :any,                 ventura:       "daf689ba8993dcf86de7fec5041637ddd8b8dcc165ae6b428c074e27a61bdb71"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "88c0d3820b2bec18bb97c016af8c273711b13df47c337735ba8bc7edf19d606c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "83bfc50c5bb638d9514d0625899a6ee7b4c55cf9ac4c307bc3d214263b867bef"
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
