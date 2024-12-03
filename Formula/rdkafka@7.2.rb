# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "40c84b7694822d17d64ffb5944e7caeab123e4e5ed7909b5b29c5132b1c8b0a0"
    sha256 cellar: :any,                 arm64_sonoma:  "68de177e6051d278efb53fc94cf1b7bde517a1c0b79f38d68f89940843f4931c"
    sha256 cellar: :any,                 arm64_ventura: "e70cf8e80aa33d4d43aee053dd1d51c6af3c3edde2a9a2f4af389cdd55cb80f2"
    sha256 cellar: :any,                 ventura:       "dc2f849bbb866d1de38779567060439f11c626120c64f5be364d090b159b81e3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "89358ff893fd25bc9f484b4076d65ca02be97e8ce62cbfbdf4828668e712534a"
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
