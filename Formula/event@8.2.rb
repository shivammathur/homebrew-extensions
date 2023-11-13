# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "7f0e62faf1be6891ad3a53004a8c2820cdeba4b82ef3bddb3f0e1f79c5fa0af6"
    sha256 cellar: :any,                 arm64_monterey: "b248559bfbbeccb03a843a1d6d39060c88aa83fbddd2133dcf4205097d663d9c"
    sha256 cellar: :any,                 arm64_big_sur:  "e60b7d3806eae5813e8e70321b3751da8d820b073a3b1660d146dfd8dbe40cd7"
    sha256 cellar: :any,                 ventura:        "ba16af4ec4a1d578074026239555d82649b97f293de32f9110f35176cf8f8179"
    sha256 cellar: :any,                 monterey:       "f883747bda8a08b7fbfcace0175099d81f56719a58be304f42eef134973abe97"
    sha256 cellar: :any,                 big_sur:        "93a0cde377b0eb7899605701fc2377e211390434b15e1b12478f6c41e7693d67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0efde43d29633b8be09334326c1f071df385e53df60ee3c52c830e57c37e1d9e"
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
