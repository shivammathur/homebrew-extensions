# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "1b269a03d7266c361d99f647ff70a58f76cf78a823d2beb04114caa26fc931fe"
    sha256 cellar: :any,                 arm64_ventura:  "30dfeaf8c06857abdbfd7cf42e88c9d6c9ef45c1d13fd7f17c148cb4468cf5e5"
    sha256 cellar: :any,                 arm64_monterey: "0fe33fadecf3c2bc3036d9ce9ad1d953794f52bccb3be0dc3055b7778ca5a86d"
    sha256 cellar: :any,                 ventura:        "9da654b0404aba8d0658a9ced0a36e9772d8450105e48523709342ff62cb0d2c"
    sha256 cellar: :any,                 monterey:       "1f7b3773b926c6b3e379848a7425f4d7ddf88e2dc00810474c35e49ac913cb9f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f92f48b0e26ba6b082404acb3632b39e939a6ffc320815de31c140b29a4aee64"
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
