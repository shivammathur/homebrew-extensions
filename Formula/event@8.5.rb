# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT85 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0fb78ccc23baac3cd78d459ee5ab1c37aed76da8633430e281a14a2b0bf4b665"
    sha256 cellar: :any, arm64_tahoe:       "81eb50dd3273900697a6ee2748fe5b24e2df97a59cbe0316385c996fbd7ff4e3"
    sha256 cellar: :any, arm64_sequoia:     "0c5304a3b327b4314240eb9df720dc42d645e54b897b009a1bea32163fd7bd19"
    sha256 cellar: :any, arm64_linux:       "4e89a4fff7bf38ae5417b390195b718d13ef590d7670e23c12e3e16fe76d7bea"
    sha256 cellar: :any, x86_64_linux:      "12c4b772862aa22bef339a7437db9cd501d2acbeda645eb8a88fa440d74d42a1"
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
