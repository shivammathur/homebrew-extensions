# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b90aec7bd914a380917c51196a0a18f6a8958c7bd38fd25868ad81c6bc71baee"
    sha256 cellar: :any,                 arm64_ventura:  "5ce52f054ff39b32decd9943c61e4bb7208845d7502d0a6b2542d99f96940487"
    sha256 cellar: :any,                 arm64_monterey: "39ffbf93155756c4b2571bc37b8bfcb078be2c19a634e2501b5d87ac8c21c63b"
    sha256 cellar: :any,                 ventura:        "c7467b98294ddf018cb65e739d0b8e20f7a6ee03c2053ebcd823a91b165022b9"
    sha256 cellar: :any,                 monterey:       "17845623dffabf2b1678f700b74c1e686a4284a097d04fa07254a7f24c722816"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c658f778df920d7c9432119c3286045c2c1c1901c91ac562bbc11810b3453d1f"
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
