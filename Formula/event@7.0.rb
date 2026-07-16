# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b244d4d90d44da7924ab9ec7795225c8b2c03e7cd9fb0aa397da9c83912ac1ea"
    sha256 cellar: :any, arm64_sequoia: "920340c0718f116f4c4fef8b00b39d11007089fcaeb76db14624a9cfd4184efb"
    sha256 cellar: :any, arm64_sonoma:  "de9d8f5e8f9f199d1e0cfc7dd5db7b886d481ab05538313eb6b9e776c60e5c8e"
    sha256 cellar: :any, sonoma:        "704db0435c7d8a2c11aa83ca5a3da7d017d42ee696501c4a0cf7c6c687a63ea7"
    sha256 cellar: :any, arm64_linux:   "aee92079b734e1a0c2f24f2332d314b33e92fcb97f9f2a0c6faa5d15cac4c0a1"
    sha256 cellar: :any, x86_64_linux:  "e805ff27799edfac4bae2276afd4a291d3ec7a9fc31e6e75c643411a213a4c5d"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
