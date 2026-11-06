# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "12b6644e345f8961029b55267749092b3aa576dfa4d6ee29259305a2ad82750c"
    sha256 cellar: :any, arm64_tahoe:       "ae3820eb50fbae8d4e6e42fe6d1993bf27abbc1ed99739168cdf558508e8b644"
    sha256 cellar: :any, arm64_sequoia:     "d944ff3ebff44fe22c76736e4ab8d7f2f5b0881d72db728f835e3f1eb7b4f8e1"
    sha256 cellar: :any, arm64_linux:       "e64a74718d5fc260f26c2234aa2db0808c410af195ac82d2ffbacaff7d7517e8"
    sha256 cellar: :any, x86_64_linux:      "1c69ea0435c32f7319b92a5ddb10d84761a61e538909dabd93aba06dcb4f30d5"
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
