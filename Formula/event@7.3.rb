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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "01f0710457906fe1faf4970052dca599742012c0b1c99212b4701c71d53c804a"
    sha256 cellar: :any,                 arm64_big_sur:  "ae5b32356b4c8941c0f1df03ae946b412ed563392c70e674488c08f5699432ac"
    sha256 cellar: :any,                 ventura:        "3d7f28d95e06b3ffe094af8354d5ec88a7a5e5371813d9299c5466d9e74b1cf4"
    sha256 cellar: :any,                 monterey:       "08216a36a8773dcb8c47999c4cead01f4d2caea898b48ca419ff04468d69b951"
    sha256 cellar: :any,                 big_sur:        "b14c827f8cfc8e2ac6cb7537b9bb7e1be2c6f70d6f8e5362d345509778dd7fa0"
    sha256 cellar: :any,                 catalina:       "a629f9145a38d233304fef55bd940424389a1e6c92076222a328e539f7ea6336"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4d9fe098bcb919b3dc2127b13c9af8b6d2f695645dc11a5709f5e0df06cf2273"
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
