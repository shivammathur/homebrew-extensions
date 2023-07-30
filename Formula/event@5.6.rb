# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "fb30bb14a92264007353daf87ad42570aaefae4cd27ff5b3693d0f1f500bda79"
    sha256 cellar: :any,                 arm64_big_sur:  "a53aaee9a682f866d4916be383c8ea65cfe1b7bad020ac35fdb1c4dc3c7901cb"
    sha256 cellar: :any,                 ventura:        "08950319f34a9f1ad902334be665766570905965c96d316482fb80986279516b"
    sha256 cellar: :any,                 monterey:       "58b1f84e2d022fcc2a57ffbe622d2a0a22116843d005db03c6f6951b0a07e895"
    sha256 cellar: :any,                 big_sur:        "48aee0a2a67512dee9d3b37637690adc449ee38b13a9e9c2add7aa2c26f4f726"
    sha256 cellar: :any,                 catalina:       "93c513e372104bef403f02a34321479dc7a1ca065773b81330aace2a390a5ebb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "88790a2c5aec886c93945f4e43fb5c0f5c253b54c5a3d0a2ec60e4a17c9a4301"
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
