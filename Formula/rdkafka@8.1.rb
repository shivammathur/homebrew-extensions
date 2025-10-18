# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "8c1fbd43f442e1f522c7f562bd06f96c3efbbaa440c44beddc99a960eb29f015"
    sha256 cellar: :any,                 arm64_sonoma:  "dc2a8b5a457c5aabfc3ef0b5441885cd63947eb1dd61c8791c637b3e80244ea4"
    sha256 cellar: :any,                 arm64_ventura: "26cb4191b278de50f7f5c204687316439e4ff6292a57d9a93b1461bbc660d01d"
    sha256 cellar: :any,                 ventura:       "a03439b04c8f128cf3b61f00fe2fae7b749e96f13f3bba89eaa0ff250dc0abf4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2e790094865771d1883027d231e316dc7db9391064ca1819af321bbd73a4aa6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "facb4bd698da791c04736e7616993242580b3840f0db6b71af4bdae429037685"
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
