# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9feffa7979a0246a6021f464bc2aa734699b180ac138f1ee1579acc6dcd7a756"
    sha256 cellar: :any,                 arm64_ventura:  "4561e3b855b2d630b38768268ddf61d5043642076b8c94748cf4a35c4e694f91"
    sha256 cellar: :any,                 arm64_monterey: "ee65a056a0fc841302ba09528a05b8427397cdd0241ff598c0ab655492aa8359"
    sha256 cellar: :any,                 ventura:        "d53c87c08977429ae5bb021c3e4bffb3cebcf560b587e5484a6e887556fb6649"
    sha256 cellar: :any,                 monterey:       "92c4c709820a6f6d0e8369d6775c82dd14499098360c478c040bd86acc150129"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5f6b7b08cae26db136b481c917a56fc01c79caf9676bab5ff5bcec3191cf438f"
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
