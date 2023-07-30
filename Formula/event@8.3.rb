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
    sha256 cellar: :any,                 arm64_monterey: "65ae928e1f9ba957255bd648e667832bfb1c2632d098d046b4c6af053a7f10ef"
    sha256 cellar: :any,                 arm64_big_sur:  "ece3f0d8b4913ef57c7347646b7b3a4bca729c19ef685077558a920ee1296a30"
    sha256 cellar: :any,                 ventura:        "70af9746e18cd0b0f2ad0af2702fccadadbfb537f3a28d8729d04b7728990635"
    sha256 cellar: :any,                 monterey:       "d5fb988ad2ea187eaf22bd8e7721cd7583e06ef093dfe7def1c305ab0d7165c5"
    sha256 cellar: :any,                 big_sur:        "1343825c68d8726a39662ddc3dfb3a0cd29908f38406cf32ddfdf17176c08ceb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38937475940ed4364c5d1333cf87a26251edbbe3b6338829062bb0b1bd229bac"
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
