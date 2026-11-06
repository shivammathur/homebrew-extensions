# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT80 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "292d562868f8c5e24d1b66925dde7cf3c868965f7118c7e0ea74ad12b076ab88"
    sha256 cellar: :any, arm64_tahoe:       "d7efcca62a2358dc6ae30bf1ebb9dfb3c8da389eb58c6df09e79c11bb2745a20"
    sha256 cellar: :any, arm64_sequoia:     "f81a510937d1416055df8b0ba97f4b7e0bce09649aad355387529b60f2cb2f6f"
    sha256 cellar: :any, arm64_linux:       "7a69bc9fb08b13c90373b0f86795ac2ad93133412ce2b68e5fe676a7670f9f17"
    sha256 cellar: :any, x86_64_linux:      "484acd8d58c7b482641b4ea2c3f60ce0725e13bd5ca1716afde70474c34e6c78"
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
