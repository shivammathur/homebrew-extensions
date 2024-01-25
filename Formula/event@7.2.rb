# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT72 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "568895f305656b886b71b642205444aab0457e7390eefc8cbb03671e2c8bdefe"
    sha256 cellar: :any,                 arm64_ventura:  "39cdff52d074379203bd9d6d300182cb5220f7e8918c3f3425a38908f3255161"
    sha256 cellar: :any,                 arm64_monterey: "c86627b1cc6500c52381937089a1ab811767ef46072ec6c720a5916eeaeaa6c3"
    sha256 cellar: :any,                 ventura:        "a64e47d84ad6d33ae2659a9e409b371872ce35a9c4baaa603d894bb96fbd768e"
    sha256 cellar: :any,                 monterey:       "9946b76b94b376e7dc9bf97eedd0159c732fa51895972f40939f536f44a82898"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f702fd8c7a0930bca2ae51b04393551d21603972541d5cb8bcaef9c8527459c"
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
