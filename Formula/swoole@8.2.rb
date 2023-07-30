# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT82 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v5.0.3.tar.gz"
  sha256 "c8d82949076aa42834681c738467d7448759ed8174d43a4ba40d8170d6f8da89"
  revision 1
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1a0b0f930c5268658bdd88af44d838b339f773823c1b05f11842277c4d47ba1b"
    sha256 cellar: :any,                 arm64_big_sur:  "efc099bf7438f7df0549aa0073dea18776dec09d69623f9850a8e13cf6156146"
    sha256 cellar: :any,                 ventura:        "9df1a508da41591800cfe6f6852721a3397c589949f92f59d713ee1a36ebaa3a"
    sha256 cellar: :any,                 monterey:       "339dd31afd8caed86cb610073e2940285da7dbc8dc0574d58ea409584cfa90c0"
    sha256 cellar: :any,                 big_sur:        "b4f94fd5346cc4f3384b91d6ccf3fe3e25f8415587acba7eacc1329cbad69d8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cd9cc39d700912f2d4a85ccdc2dbe3fd460c879839472bf66f24fd57d576db82"
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
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
