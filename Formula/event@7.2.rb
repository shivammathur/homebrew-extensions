# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "a52920eaac313d7a4568216f3a2a6b31bf5fdcb84b1bdb5f8716bb1642ab2540"
    sha256 cellar: :any,                 arm64_big_sur:  "cc5bfba32d90ae8d10d47ac3de6a3fcc91bf71fc12e357c8086804e23a402c48"
    sha256 cellar: :any,                 ventura:        "3a79cd9b79aec92f1e298444b6ca828faa9b6b19ef076aeec7364afc8a15b457"
    sha256 cellar: :any,                 monterey:       "4aa8cd89bc43d36a82d08e4c3719d04f949085a565f6b98fa26d5a373fd7f230"
    sha256 cellar: :any,                 big_sur:        "bd8b6e1d43e03305379a1b28c6deca22a5a8cb8b7fa91ef475cbab84d887c59e"
    sha256 cellar: :any,                 catalina:       "3a9b6f6a8d7b94ab6ccee9c8f4936deb57280bd05c8d732f4165b7a18d0e5bad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9ce9df3d12ec333d37d33cc7986103354d9c3769eb7e5849324ce0e186a9e669"
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
