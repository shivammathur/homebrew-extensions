# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.2.tgz"
  sha256 "2de4f45ddea90da53fe0a811016e421b4d2e4d148d4ba2f90c19ac2494c23339"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "b0c0c66461cb19243b582314f13badec10745034501247dc77ad2dbac06b575a"
    sha256 cellar: :any,                 arm64_ventura:  "17836128299863f0f015212bfc8d63f94a33211dc9c7f6de5df018a091341146"
    sha256 cellar: :any,                 arm64_monterey: "ee3cbc6252e574fdd7b11c14f99400f649185eca7f710531fff4307e485fded5"
    sha256 cellar: :any,                 ventura:        "6a725d81f192eb2c6158587bd628e4a5fbb3a8954520bcfb8ccd895e04f88293"
    sha256 cellar: :any,                 monterey:       "7788910ff01cd305bf1f8103052c40b3ef7a9aff59b1007c8c22ca30564b6637"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0321ec6c076b6a4463af0fe141ee4536b5eef8aea4d323c978efc14a5a4da122"
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
