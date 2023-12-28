# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "331d1883a049d5448dc7840a5c852e0fb63f76316b1cc9e644e8a077876e2eab"
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
