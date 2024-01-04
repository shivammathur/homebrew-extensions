# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.1.tgz"
  sha256 "d028f0654f83e842cb54a7530942363a526fb0da439771c7a052de6821c381ea"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "4e697551cf34086387c3be0a7cf62349608e9365eababb8e5a36052fb4bc677d"
    sha256 cellar: :any,                 arm64_ventura:  "b0491230819f073cb8423cd5b34741acc1e0e26d064f1dce9d2f447171f251d7"
    sha256 cellar: :any,                 arm64_monterey: "80f5d4b0e7aad956edc5e158034ff452735d3c0cd00e3b16efadaca4b06dc3bc"
    sha256 cellar: :any,                 ventura:        "6305f7f1978caa384184362a11d82c7fe8e9aa0fe14e7ea6eeeae9e765030a8e"
    sha256 cellar: :any,                 monterey:       "b1abf7642eaab2bf87677f1c086db4e0b3cab6995443044c04c5f69f7f5f0e00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "47c4d2478bc839e0d076536a13b99f2fbade0f54dcb68626a0d73c1cc69e905f"
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
