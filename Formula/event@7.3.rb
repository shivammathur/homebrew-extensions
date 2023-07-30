# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "58394bc9c1ca78aafe8b2d040fed1b3bf017952a3b57b56caa32d327b9eecf4c"
    sha256 cellar: :any,                 arm64_big_sur:  "6508f45976dd39854cf65f1adfae3120d2d7256a35edaa16ab6934e6c3e4f0b1"
    sha256 cellar: :any,                 ventura:        "bb6d61e126dbaeee1594f55571a0b85eb8817e47c058564e6ef36225414f6f9d"
    sha256 cellar: :any,                 monterey:       "f8358f3414e41816357d3a51464f87e5158753724a8253869beba7f4218d6b82"
    sha256 cellar: :any,                 big_sur:        "5d77f653b587b20f5d496ab6765c2779b73fe5264357d4f406025592087d4f9d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "725bee7f695acf28d5625c6ed43be5a05b71c1d9e0c39a9598e00e00a692b46b"
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
