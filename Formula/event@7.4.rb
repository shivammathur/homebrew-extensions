# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.0.tgz"
  sha256 "3e0e811c54a64b7c6871fbd4557cc3f03bfd31a53f9504b479102c767a23ce41"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "5be1c66564b59a0e5881488cce3827c0280bff357b3f0ba654ca44b09f248dd5"
    sha256 cellar: :any,                 arm64_monterey: "2fcf1e5df42eb79faf492aa32c8fa5e8145517dc4646d0e3863c7f4750e03d22"
    sha256 cellar: :any,                 arm64_big_sur:  "e36be118970e99e84005b49775c044db6d3e2e7284d6aaf9c429e8921d8ba699"
    sha256 cellar: :any,                 ventura:        "008e1d37f1e1daaf5ac9fc15cdfd892aac7313843f3f2d648feb72f847902d15"
    sha256 cellar: :any,                 monterey:       "d59b648b87d769ad46deb5a5934b67568c67580d99c52f5fb1c4a6a8c79dcc24"
    sha256 cellar: :any,                 big_sur:        "49df35b963606f99ca37b9c3b395efd5f02a0a0f2f244ddf0f746a6fdc760fdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "40519d61252e67ddb7148447897a4f8002f55c310d17be710856151b9a1d1375"
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
