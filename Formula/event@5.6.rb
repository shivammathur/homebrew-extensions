# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "9a00635610e3858903d391fab3a167adb99a8ded01e85b0ab9cd789fc308bdc1"
    sha256 cellar: :any,                 arm64_ventura:  "b87035f5a039f9fdd32b59fdaf9b6f26ed6fa0a398d635b108255e4ec0f497fb"
    sha256 cellar: :any,                 arm64_monterey: "d72328837e13b157bed62325614a2a5d01a84731780e58a86ba98b0a49161c11"
    sha256 cellar: :any,                 ventura:        "315d5fcc9760cc846fad7bba956f699286db33e47ac7c404560e46559d4fb061"
    sha256 cellar: :any,                 monterey:       "b161373f5af1296f6bec22ede9f77665e50d81f1d12bfe835d927368e60bef42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ab499b17dde629719a9cf8f4d08e440eb0b456bc763ae3b523a981990b3aa00d"
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
