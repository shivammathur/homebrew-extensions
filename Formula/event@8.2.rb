# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT82 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0b33ca184dcc224bc7869e3aa50124f88bdd63dd846ba55b21663b2eb382f4f4"
    sha256 cellar: :any, arm64_tahoe:       "3bc39a2826fff6045ebd6cde8cecf13c1875f61218720cf87dc07f55b1bec478"
    sha256 cellar: :any, arm64_sequoia:     "785cc9835f75636390dac888ef08eab8ce2df89a0e2358f52edd75f3948e5c1a"
    sha256 cellar: :any, arm64_linux:       "c7b84984887df13aeec8524c943790f1d7ea5b0e8a50993f5b49022c2b2f000e"
    sha256 cellar: :any, x86_64_linux:      "84a9487260b17e4c1785006672e099022f1c9f3c2e33f8259adec9ce44710fe2"
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
