# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT83 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "e95be6e00480f97e0d41e581e77fd61351af33dce3758d226aba98126426277f"
    sha256 cellar: :any,                 arm64_big_sur:  "5299c339b82634e3507067e5ed5e61be5fb9b283da0bb2e241eb0bdb4eeef422"
    sha256 cellar: :any,                 ventura:        "f71522f59558937f4617c984c47d4f283d82dd75e65218eda1f32a82f95e3067"
    sha256 cellar: :any,                 monterey:       "67ae8bd28505f6838ada286a5573dbec5ebb02f58daff1eb4b8cf70a095b55c5"
    sha256 cellar: :any,                 big_sur:        "82bd5c0175efbd4c8c09bcfa621870ff21ab59ada5b8d480470ab0c321886ff2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b1e9b92fe60fb6da02e46ac3b5c9db245b9bb469afce8d12a3df22ac568c7405"
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
