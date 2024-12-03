# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT85 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "a4a561f4415e2232428e4aef28871456ecbe1249511157e2459046f79246b470"
    sha256 cellar: :any,                 arm64_sonoma:  "98923fdef50ab5c3b29bdaa1d40b1ce96490119006462faf7920ed29eef79d09"
    sha256 cellar: :any,                 arm64_ventura: "5b92ac6519fdc935ef07c6c21e11930b7818f4dfc7a75a8aa2a2ea9420312504"
    sha256 cellar: :any,                 ventura:       "18af60824b56023b0ea330f046c4839196060a153ffa3f190bfb12b90a156ba3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "449106df02a2fa61d68c8785331a30a1928100f6975ae5372facf5aa1019907f"
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
