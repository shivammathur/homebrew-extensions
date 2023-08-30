# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT84 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "3592efe3795f77635f2e71a72a678ee659ce84793ad3b5e10f6c9ec87ccf9165"
    sha256 cellar: :any,                 arm64_big_sur:  "5ec1ba5137c3f2edf0948b435370a7bd0d27556dd3aeb59c5f1d87b7566ae214"
    sha256 cellar: :any,                 ventura:        "d653e4dac30d17ed2a260acd655a7b5042da3cae9f007f5d1f850ffee54e3ff3"
    sha256 cellar: :any,                 monterey:       "7ca11438f29c21e58bfd70721adcc153ab48f7227edee8ebddd3e58397677594"
    sha256 cellar: :any,                 big_sur:        "5c310f466157de8d7a0a1fca082c1f98cc199a0b3a054421678e1b7775f9524a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ad0eb26149697a482b96fce2376efb86e9c807f0529cc688dd4f9ddd03e031ec"
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
