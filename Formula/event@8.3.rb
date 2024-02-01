# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "eaebd782c2abd828c5ae5cc6e7cd7252cf7e06c9c5e9bd47ffe421bed7f9597c"
    sha256 cellar: :any,                 arm64_ventura:  "69296192ab0fd26cf44174c0e86cf6012f2dae49d46b6370b50488935643b4fb"
    sha256 cellar: :any,                 arm64_monterey: "d1b80267fdca0d2c2e80fdbd0008ce3e94a3cfd1234d2d57516dd167db21e5a1"
    sha256 cellar: :any,                 ventura:        "9c363b8524347c5c3c6e2ae7b1a643a02ea2d80e5c00757449d1df803e4d4271"
    sha256 cellar: :any,                 monterey:       "252fc24f6e9f4eeeb0d78aeecc8ae377eee10e5d008381bb884bad7d992ce960"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc1fce1672c01da04902db2ad5b0013c17089a523313c61396de5b48bdd22209"
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
