# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "814ebedd123183c1669cfed5b0f37c3bb2c25182fb6e6b9aa26259375fb27d48"
    sha256 cellar: :any,                 arm64_monterey: "ba790d6b8104a8662073cca548a56f0f5461e9e9ccfd44555e6e54bb4853b93a"
    sha256 cellar: :any,                 arm64_big_sur:  "d28017548e7cbb38880432e38cb241dda47f5a37d027af278318e727b96b7801"
    sha256 cellar: :any,                 ventura:        "8600908261cc9ca9d6c71e6df7982a3d68caac794370fe7c8bba17a6637a69d2"
    sha256 cellar: :any,                 monterey:       "1b580787f4abfea46b301828acef943d9b1103a9513e8c42163067f7600dd4b8"
    sha256 cellar: :any,                 big_sur:        "fbade832db73b74dede7ff175d702ab1dcb101fccc197209affb7a8492146ca4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e408e9634c5ccee79e1ab5bf0a2f8eccb8013eddf7177f1f023a8a1d7d0f882"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
