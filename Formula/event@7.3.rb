# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "6fde7512743020f4566eb1b6527a9e5b190061dc36289f129568fdddb35a4fec"
    sha256 cellar: :any,                 arm64_ventura:  "129515db2e7030f4291fb64949f23baf9bdb267040fcbf9c2ebc7a47eb0fd258"
    sha256 cellar: :any,                 arm64_monterey: "8d5ab3c78deb21b2da31fb65b86d9c3eb90472638a37d2443599f9599c54d8db"
    sha256 cellar: :any,                 ventura:        "be5d8a47708e7b9bd1aae94e1fd6035d4602cae417f5c81878caae993c23e023"
    sha256 cellar: :any,                 monterey:       "bb69f6d90970372ffa231ea4ecc9b1b449910055a476d98952fc51e304daf1c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fd85c7e6c41ff043674a04285718b1967ccfa1ac58b0dcdb831ad4c5e63791a1"
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
