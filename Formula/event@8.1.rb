# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.2.0.tgz"
  sha256 "fb3d4e3c9fdc79125274f2b46461492923edec6b489ed7077973f7e65f41dc1c"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c38b32bebaa25283c1cc96964062553a6015c708285fe80b440789185045e574"
    sha256 cellar: :any, arm64_tahoe:       "bd411f92a707c0bba3311e94bb82c6589ef944b2924258dcea26bfbec4c53841"
    sha256 cellar: :any, arm64_sequoia:     "4b47888eea2719a956f7f06d8e2f1852d679f49d7f35b946c576282be402d72a"
    sha256 cellar: :any, arm64_linux:       "dc9d9b8ba9ee6a38c823cdc3c4c77bf925bc11db18d3e5786ffff38b64949d4b"
    sha256 cellar: :any, x86_64_linux:      "cfd487e4d03b8b4c251b34dadc171b6fc10d0d05997759ff308d744d3d308d46"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
      --with-event-libevent-dir=#{Utils::Path.formula_opt_prefix("libevent")}
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
