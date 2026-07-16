# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "0bdc213d2890e86a830bee4172cb6c23ea13c2d41939de85691cab79f2d24a74"
    sha256 cellar: :any, arm64_sequoia: "8b2d8f8fb35ae23c7119e065d3e0bee5c3e1f0f464e14ecd154d65cb3d33434a"
    sha256 cellar: :any, arm64_sonoma:  "b391bb305fe5e6e91b4849ec84bda698c7f2e710c6db370038a243d133c84040"
    sha256 cellar: :any, sonoma:        "d7ecd23910383bcabb6463234f368fc3f17b28229f6113d453aee058bfab8a3e"
    sha256 cellar: :any, arm64_linux:   "4db1877a27ff93a6ea8ca09714b2c068f77f820bf68e712e3764c48b1791265b"
    sha256 cellar: :any, x86_64_linux:  "b2fda85f4aa8cdb6253a7e9ff971f35115d963360d0bc7997efc76309498022f"
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
