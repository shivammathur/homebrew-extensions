# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "45ee5933156fa81c04eabcc34899c1ce58f8ef4a46f78338df5ea83f6aa28b28"
    sha256 cellar: :any,                 arm64_ventura:  "b61a7aa49673ea2f79f83422393fb86d3d7d7741507458c3b63ecdbb7c518cdf"
    sha256 cellar: :any,                 arm64_monterey: "25b3d45a35ce666494d39d2cffea210792ce41ac61db35563de887c47c11ecfa"
    sha256 cellar: :any,                 ventura:        "590fbdbbd503ccc16bc54bd8009031e545cc62b119326daef854e977a65bf1eb"
    sha256 cellar: :any,                 monterey:       "784b3720e6e3bda5f77411fe145f63abbb4dfe3ed4b9b145014e504d6d41b39f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3fa8f521ace349964d98f43503c3f9e2c6f662b5aca65dcf00f756a858d78e4e"
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
