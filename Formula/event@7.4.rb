# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "98eb86d84507e23a1b2f98386f7ec8ca5f7735feb09d4e54f19a5c7e58964f08"
    sha256 cellar: :any,                 arm64_ventura:  "654a06e34f215de7dd43e5d0afc173fb2cdfaf12fe94f28956fa5176433b32e9"
    sha256 cellar: :any,                 arm64_monterey: "5ed37a776feb6f57b8e001e203707fb134682a6b62f37184b69d1910887dbf46"
    sha256 cellar: :any,                 ventura:        "98373d121278c3027d29e790f222bea14ecf649a1782b463f56e65b7b6b9fd44"
    sha256 cellar: :any,                 monterey:       "fbd5554156c4fff3c8eaa9d6de9394d20305a3a311f4850647dbe21c1e40533c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "94255fa19af1e73578cbeb4f2909d26155d826958c8f641bccfbdc665c71a4b6"
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
