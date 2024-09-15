# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "8dc714d457c1a7abe19cc006ec9d5339c5296b5a4faf31e4ad37cce7e5d61ee7"
    sha256 cellar: :any,                 arm64_ventura:  "a2fc07eda2d3e206db2d21ff873ba837e134ff2b0eda5bf7605e8346654ac6c0"
    sha256 cellar: :any,                 arm64_monterey: "459577b1673b0f58dacedeffeabbbf2ead267109e588cad9819a98f53d71ceb4"
    sha256 cellar: :any,                 arm64_big_sur:  "e530788fe7afe4a936cb85004d5556a47862fd759c787be176a30807ac97beb4"
    sha256 cellar: :any,                 ventura:        "f52b221e09730d7a7d08055655236c8f6e8a46eba67ec5fab900139100fc19b5"
    sha256 cellar: :any,                 monterey:       "07947f36aab5cd2e34f27cf1c215bb860cf00353183adb2c7f953e0301d47244"
    sha256 cellar: :any,                 big_sur:        "a227ca6a10844ae7c00cf2128a0bbe12871cd0f364161fe0fca845ad5b93dbb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dc1c7ffd18105d870a52add708307caafc12805dc5cfd204ca721d6deb592811"
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
