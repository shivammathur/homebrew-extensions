# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "8d69509fba75bb0c9d0b83809ee48be65cdcda4a412930b26cea23e45d397ebf"
    sha256 cellar: :any,                 arm64_ventura:  "c0abbe13d203d0c77686c0a94559df8c2efe4e199d4cc17602201ce248b6e5d8"
    sha256 cellar: :any,                 arm64_monterey: "c1e514cca6f6e71b0b6eb7a72ca7753634104d85ed48cf4b206770b0c235dd51"
    sha256 cellar: :any,                 ventura:        "f36a19b4ec62fe8785e0e0b2067333ed2bb962a48e08c6ee9cf0cf56b8d3c80b"
    sha256 cellar: :any,                 monterey:       "ca07beb1a094db5e2c79d732c41bb1e60df5dc1bc8a4e0f9655a0ab7e05d0dca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6c40201a4adea79af22fb1d34de11ebde09f4221d896922ff49d85633f192dc"
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
