# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "d46a8a179e07a5f7490fd0f26a82a302118c80a89bf31165006f792788ba210a"
    sha256 cellar: :any,                 arm64_monterey: "4d28b415a47c1db4ce9b0495ca23efd481354a39fe6dbad9842990fa27968539"
    sha256 cellar: :any,                 arm64_big_sur:  "7152d43a6cd5fc43a24c7600e69ccccc7f1c20199e0597905db487033a8e0aaf"
    sha256 cellar: :any,                 ventura:        "d013ef859410cfe471e24baa19c75b3473745d8f3143262114a6161a76b697e1"
    sha256 cellar: :any,                 monterey:       "2b346ee7a7eab7dabc7c722d6c37d6bb14ac1c0418cc3c068619da1bed6b1d26"
    sha256 cellar: :any,                 big_sur:        "8cfb4938684279fb7d5f86215ab444f9994503fe7d8f418c4f89e1f5669e42d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3898cb4524c9d670fcc7b88b7686ac1945f5f00f63acb9c3a53ea15e4c2589a7"
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
