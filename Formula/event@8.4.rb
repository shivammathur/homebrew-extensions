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
    sha256 cellar: :any,                 arm64_sonoma:   "29ac18b0dc8313c03adf2022c923997e88ab1dda5eec27490893e7a2e25f2ed1"
    sha256 cellar: :any,                 arm64_ventura:  "740c5a0e5a491baa9caadc84d8ca423a4521db05e41ab3e50c74c1b23cf88d39"
    sha256 cellar: :any,                 arm64_monterey: "1c5950b385dca41f419fb1c5b8b1e5888da35be847cca9740e4bd4d444d91aba"
    sha256 cellar: :any,                 ventura:        "36c6c0771d0fc18fc7721593abfce2067cc8d002d8e25ec344366f37310cbd7f"
    sha256 cellar: :any,                 monterey:       "7bdf827c4cb8c0ecf7770856ab0c2ea850dabc3076f439e66cf885d5d483ccbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a15dbf13dff5fee2b737f75c44a1c93de0661c9d2864043253dc12836e17f798"
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
