# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "dc18ea4005facc72ca46d81cef1e058e77c4360ef04193064aa922cbaa4aa7fb"
    sha256 cellar: :any, arm64_sequoia: "d57f8ba9bfbc0d4b95b38419c1903020416e2f2f32497e05f178a48958dd1d43"
    sha256 cellar: :any, arm64_sonoma:  "64a51e75b348ae6a715951e579c7d8d69c53c5519fac9a59f103cdd4ba8a6b3c"
    sha256 cellar: :any, sonoma:        "13ac88efdedf17adca838d6cce9c9cc8a2f2d191f55987f9aaa407cdbdeebd7b"
    sha256 cellar: :any, arm64_linux:   "8e7690196a49863e8770b63337db957e26aad25aa8f82394dbe202eb8d1d4240"
    sha256 cellar: :any, x86_64_linux:  "a30c3b832825f574f3f68a96ed0e380bb747a9889f67c5d4600b3b8fdc9dea07"
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
