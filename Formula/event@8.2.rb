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
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "74ac98a1a5e2bb9f2a5fdc18cf05edb4fb66a8be865b00ecf8399464c01d5f76"
    sha256 cellar: :any,                 arm64_big_sur:  "c2c2ab0cf43b5d75ee8ed8fc9f4b94d768b1899f1d0b53326ef3a0a0ec24796c"
    sha256 cellar: :any,                 monterey:       "353d8ac6f06c1432d47df92c56480ea414672b2b73cae5fc9fea0ae4d3a1d30e"
    sha256 cellar: :any,                 big_sur:        "bb72fc38404b08efb2ae129dc83e96b0b7c11a1199faeda12629d95d99e75afc"
    sha256 cellar: :any,                 catalina:       "879f358e17502d5164063a27f0748d038dd96a17c3cb499d41981670a8682261"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3af53d338a943558e034c8ecd97e2b565bea8223e308c82b90b50430410a2079"
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
