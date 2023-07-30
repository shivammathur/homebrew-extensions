# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT83 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "f6308d67c4e743c9e5eb05ab9a8b22132144ca85b8e8023421e16419388d9c54"
    sha256 cellar: :any,                 arm64_big_sur:  "544e8af32a87515c06d00e7cb1c9b7a1740915e777f750a86b1a4d72e1c79b33"
    sha256 cellar: :any,                 ventura:        "b2b62b09d2aacbc7c4f839706aae67f0fed33d6ee7190f2610a78a9085f48695"
    sha256 cellar: :any,                 monterey:       "613a17eaea2bf96728e5608a65c11c2ba35eb2363bbd36c99120f5a2525f24c7"
    sha256 cellar: :any,                 big_sur:        "a98f00b6f975f59c414d9636c7274b616d82ac55ff1b45251f5e890f7b221db8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e3376b0922a721b3179301aa326d172496da93e43a57c15677b646498ec4aef8"
  end

  depends_on "brotli"
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    args = %W[
      --enable-brotli
      --enable-openssl
      --enable-swoole
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-brotli-dir=#{Formula["brotli"].opt_prefix}
    ]
    inreplace "ext-src/php_swoole_private.h", "0, NULL, 0, ", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
