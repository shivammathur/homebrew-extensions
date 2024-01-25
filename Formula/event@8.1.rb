# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "a1a35a6fecaf8c57d8c239a7d8bc8a4d4ce3dd1802c9ad14cf8827fa659a26e9"
    sha256 cellar: :any,                 arm64_ventura:  "b24247e7e1b737f07cc32be1626e6d9e91cc15df33dde20c9126f2fd45561ac5"
    sha256 cellar: :any,                 arm64_monterey: "6289587d7afd3bf4d62db7395b0ff080e94849844b84d3da73a17647086dab7d"
    sha256 cellar: :any,                 ventura:        "e34150de95f9dd98b062753672a1cef2426b5ac6c6db82a13548fc99c0d38105"
    sha256 cellar: :any,                 monterey:       "bdea6f87e5d657c55486e0db229ce3b7771049dbaf1f151a9592b0e78c8852e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "53282975d7d56b4a26b00b82bcd07c8e6cfc97c4f924199bf244788019a5bbc1"
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
