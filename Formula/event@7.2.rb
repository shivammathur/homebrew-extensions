# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "d92234860372c59764ad047ed7b4ec36ce374fd9996f703f7a5152af7ce2f0b6"
    sha256 cellar: :any,                 arm64_ventura:  "a738d5b577405edddb9404cbeb93bf07c60a14cc610a39b12b4efb9444b460b1"
    sha256 cellar: :any,                 arm64_monterey: "d53fc31225c48fcb6be4da4bb7189711b6614e2a52f9f967a47def6667409525"
    sha256 cellar: :any,                 ventura:        "7f54af9fa701cf606f7a24f98506d0e998adf74f929363cef9e051388acc7042"
    sha256 cellar: :any,                 monterey:       "0e5f3bbe5a7b4b00d81b881e9e10ee05d9980bf9619564c8e1c733569b133294"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8048e9b6669151e2525bd396ebd12110a8aade69ac703d158eb3a81f682d28b6"
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
