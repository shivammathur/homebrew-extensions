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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "a76a291f69823af7e083487093e10b139be3114f5e73c4e3fe23717a82729a23"
    sha256 cellar: :any,                 arm64_sonoma:  "14ef7007dd1f38d625a37e3fd2c0c45461370839c8f624566981d25592d26dd1"
    sha256 cellar: :any,                 arm64_ventura: "3bedc5715ece88718473002f6a27055ab475bd22b85ec8456a1e8d95b8477b54"
    sha256 cellar: :any,                 ventura:       "8cf0d5f096386bd95096f16eee4fab63d82db5dc4bce18b19fb197ce708aee2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f63f2b6a4073467adcc87b6848c6003270824e5ca590e1c3e4d11d176194fe55"
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
