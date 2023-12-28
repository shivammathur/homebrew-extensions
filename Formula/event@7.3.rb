# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "42495b167faf049c1675d643f9dd5e7749f3293b78c11d553f22a151cd7bd314"
    sha256 cellar: :any,                 arm64_ventura:  "4eddd5675cb7312027496ff49864eb9e83314a8f01fdeee853b224510337fa98"
    sha256 cellar: :any,                 arm64_monterey: "e295e04251039c08639d42d49e44147a90bda2499b9634789b611ee109ba4750"
    sha256 cellar: :any,                 ventura:        "fd6945079014dae781ed8cf87768a8efb6a6727208b5ca46272cf698640ead18"
    sha256 cellar: :any,                 monterey:       "1bbfb9d742b166a3a329c31106c128f20c410faea8aaa613a7eaa2e6e9f2a697"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c4afb99eeced4dcf1b675b843476b253dcc4c92e0fa5db77a23d913091e5df75"
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
