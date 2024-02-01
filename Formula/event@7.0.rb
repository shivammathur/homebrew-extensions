# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "e960b14effbee716d688b36c2f87e5ade595a0168a8bcef83d5e9bdfcb859e10"
    sha256 cellar: :any,                 arm64_ventura:  "e5b9ffdeaee1b8c67fea8dbb4aec76039ab0aaeeffe40fb0d0132ce2877f95d6"
    sha256 cellar: :any,                 arm64_monterey: "49140b80e3b58a96f373a4e15c222d3b0fead7fd59f320858f3d0eef0aa8726a"
    sha256 cellar: :any,                 ventura:        "db330f849c1f23ff4ac63650ffb3c878e84d187fc9f17897b237eb32c825f8a2"
    sha256 cellar: :any,                 monterey:       "2271f2fb1c0f438030abb706be2b5d8bd94f7c0e342abbd6248feee88331fd88"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "917f8e950bbdae132e737100c7cc34c3fb30043462cf5a054e15c6a5817cc204"
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
