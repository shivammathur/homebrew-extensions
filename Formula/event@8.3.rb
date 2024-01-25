# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "aabd09ee65acee54053f4ead8672c7d170def3d1b098564d2ba67d4ee4e62fab"
    sha256 cellar: :any,                 arm64_ventura:  "b4f6eca008e911aae4e7655e235c75027951eb8f602798e6a0dc5841a4e6e881"
    sha256 cellar: :any,                 arm64_monterey: "ee32dc4006a22826d8064a87053fc898e8a8c7f250bc4b55698ace6fc546dee3"
    sha256 cellar: :any,                 ventura:        "2ec133dce8ab72e37d3637f4acc903a36c72f336eb1b6ae72510027126e43a6f"
    sha256 cellar: :any,                 monterey:       "a72323d02e5e79273763473a2af0edc6c0d17a6aef1bed98d02470c12598ab37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "74a8a671e26cd21b705f984982d678ffa680b844e8e60abb1eb633e73b0edc37"
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
