# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "5b5fccd9d5cc37c64c036506ca9e59352a13090cfd22cfc3a7129360ee5b0f9d"
    sha256 cellar: :any, arm64_sequoia: "05985870f20fe9ea4aa4b8f3dabce48e7c74f9f1a040c5ce00d8c85a6f7249f5"
    sha256 cellar: :any, arm64_sonoma:  "582136acdfd2efa4e6ad834c6e7fd39e78f0b9e77556bb05519173efbe63d1c8"
    sha256 cellar: :any, sonoma:        "05cc9e98b5e10f9019bd1da5d76efc2ea14a835a0cb87f1fd914c8d1e11a0374"
    sha256 cellar: :any, arm64_linux:   "470598964066766ee5801ce18908d9503524dc3d2492f6b168c04a869ac2d579"
    sha256 cellar: :any, x86_64_linux:  "fb5869b2f73bce0d83833ba36b2d8278392be16cfc06e869a34ed8fa91c80e31"
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
