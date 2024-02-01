# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "39cb4345b495838e18aee5f7b2c75006e2b69c787dd1df31609b1f902d5218a0"
    sha256 cellar: :any,                 arm64_ventura:  "d039ab9651b9c33c7f3da1c26bb93f34e4c292b16bb1665e01bb8f4584a5c400"
    sha256 cellar: :any,                 arm64_monterey: "91aeb53b4c1216dadc44a39929e63611465523c118ee445cc863007b3a20c34a"
    sha256 cellar: :any,                 ventura:        "93b5f64092dddfda8e681dd69e5084f997424a9de292ab0d2ca8fe7c8e219333"
    sha256 cellar: :any,                 monterey:       "37f159051a7a4762232e3eef60acf7c7d2e2bc88911df548f72f0c59dbc5954e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "017f60f318992933c1e4709cdf7903d7fe90d163ed1a882f7af4e96a56bf1609"
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
