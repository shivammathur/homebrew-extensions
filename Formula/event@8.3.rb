# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "64d80a9fba29073bec817e4abfaa02d78319545b83d75e5b29702a2d3da58aa9"
    sha256 cellar: :any,                 arm64_big_sur:  "81cd1d8573e49e627955465af076987e4fd58d0f5629087d3427ac90f5cae60b"
    sha256 cellar: :any,                 ventura:        "fce1eaa31daf74cd9171fd1003a3ff0d6354730aa94c2f22f25b75118ecff644"
    sha256 cellar: :any,                 monterey:       "e7da5d7cc253dba9946e8c85c9266c72207b9b1069828d78a359acab9bc7003f"
    sha256 cellar: :any,                 big_sur:        "0d91eca001f3d4d51b7cfeb48e7b02371143dcdd9eac1878e4e7acffad6f5fe2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "75ff4c1d429e3dc913bc07bb7a188dde2fcabee68fd7b356bfca5eff31147b25"
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
