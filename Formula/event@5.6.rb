# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4cc1ed613f01ba4105d771998ec62d50eadfb0ed9dee494886e1bf5164578635"
    sha256 cellar: :any,                 arm64_ventura:  "dad47513c005c6b21b2c30232822d358770a71d830fc50d42d93bc83129ad015"
    sha256 cellar: :any,                 arm64_monterey: "ba0107b96e88bf47d8c5c9c39d873dbdd866681b486428e057cc278ef220f27a"
    sha256 cellar: :any,                 ventura:        "17984d41136fe31a6587735f7cca8943afe225ceb94720b5b56661756f234e5b"
    sha256 cellar: :any,                 monterey:       "f415ecc3488377b1d075b433f662a5caf992c64d8d0ec7da5c3979568835604a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "012b64bc12002f10470352442f236400672be5130a9ab53e6f68e03675102c62"
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
