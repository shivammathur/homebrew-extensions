# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT83 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.0.8.tgz"
  sha256 "e3e91edd3dc15e0969b9254cc3626ae07825e39bf26d61b49935f66f603d7b6b"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "ed739502595acfead96ae44148e51c98cbcaa9c7dafc9d641e7d7599d29f972a"
    sha256 cellar: :any,                 arm64_big_sur:  "b7955aef43889db480a9647887cd75ccd3aee1ece9647843589a3e9b3b735abf"
    sha256 cellar: :any,                 ventura:        "df2b18b11064d4bb16a2da9695c4dd3818520b4525869907918c3e7ba28190f8"
    sha256 cellar: :any,                 monterey:       "5666f9312a0c8a54920a4f6e973bc9ed8df51618e017f8674ea880cedb9a27df"
    sha256 cellar: :any,                 big_sur:        "59c7d58d49978df269fc4d96db2fd7a04e1ba5f72b29491a47fe6b5bbc72e161"
    sha256 cellar: :any,                 catalina:       "7c73392a9e31f22baf5508c40be727d772e0c7751d13b2229b3f6a047af5ee3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "90ca8d19ca42c0785edb270bf6d92c674e7fba4dc36073080848fc9792b859ab"
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
