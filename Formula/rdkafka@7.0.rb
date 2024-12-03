# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "18d1c11de8e66c6ac0db759635aa2acd05b4807c1c01387d8e86abb94dece5c6"
    sha256 cellar: :any,                 arm64_sonoma:  "c3114afde12879a651aaf17082a7b7914809e78cccdd5f67d9270aca588fa188"
    sha256 cellar: :any,                 arm64_ventura: "aa5d61fb8d511b15eb962e9332d78608a33d7c20f55d17d17d159599b20a7381"
    sha256 cellar: :any,                 ventura:       "65c5d5e372acf84179218134b62ba7164f5a8a03b4a1f9a99297b9878a3ce61c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4445ce87599e3798e2e717d0aceb5fb8a5b98b668f1824399af1e866e2d2c7a"
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
