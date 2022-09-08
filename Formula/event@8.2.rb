# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "0c9647f652cd9750af34e251855045545d7aeb8ae421132336aa7af32172cbc2"
    sha256 cellar: :any,                 arm64_big_sur:  "99212d8f07efe232b42f2947d940ad3101706cf012fb95606a1cc10c5e202e2a"
    sha256 cellar: :any,                 monterey:       "39767617f5003493aaf217b94f2e0e631257c6db0ea9e3277fdde5bb3018693d"
    sha256 cellar: :any,                 big_sur:        "175df9f358c5bcb936d1f6d4359cfb6300e5432531271e504e7045a56dcd7f78"
    sha256 cellar: :any,                 catalina:       "828d0ced6e911de6cc25a2437f87f7e202c906c30367b9ffa0d50157cd12b6e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a4c9facd341251e1a1511b447196cf77cf5f320d09c960ddc8357c8d2d77ce6d"
  end

  depends_on "libevent"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
