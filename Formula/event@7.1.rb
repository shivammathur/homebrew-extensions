# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "0e3f6e82004d9adc901d442efdb18e119becc04bf530229e2540c7d44e6ea652"
    sha256 cellar: :any,                 arm64_ventura:  "c0450e218cadd31cfcc5371ee4007e96a44207a6e1fd145b80e6e6e11d4e142e"
    sha256 cellar: :any,                 arm64_monterey: "4a658fb04164170bfea43aaf9502a68c79bcd82abc6470043a68ffb2e862c02d"
    sha256 cellar: :any,                 ventura:        "fd569fa58c06e58dced6637ec2478ed23b26667d144dc4bfbab8757af6e2e426"
    sha256 cellar: :any,                 monterey:       "a87da6853eb7a0355a5ec9615f0e160561dcaaac96f6ed84d0a422921eeccfd2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38c817ab98f6c1a53af357a097dfe98eb95dbf2913d35125a8b5e7cf4132efbf"
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
