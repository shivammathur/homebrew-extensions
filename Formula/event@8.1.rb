# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "37b0c9c703989e2a7749e2d3def016ab92df3a33ad76ad8d264154a6f759b2b5"
    sha256 cellar: :any,                 arm64_ventura:  "d23a782fbde9499cc6330d85097c204729d848ba125193504de5f8fccfa7eafb"
    sha256 cellar: :any,                 arm64_monterey: "0b372e330116213e53bd278d0042509a79f6a442f08fde82a31b3ab335b0d1b5"
    sha256 cellar: :any,                 ventura:        "e98e00500ce0a4e0780e8580761215d211bef2cf5d3e7021359a65a1a534f5ad"
    sha256 cellar: :any,                 monterey:       "0fcab986f2726576efbe4fc76c1280ec898ebaccd3c226bd680de51a904747fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a1173d0b0859cff9950fb6c0d1ff5eb9a7ce3198b2cae1e061867f1b0b473d8"
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
